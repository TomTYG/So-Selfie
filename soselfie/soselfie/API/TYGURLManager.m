//
//  TYGURLManager.m
//  URLLoader1
//
//  Created by Tom van Kruijsbergen on 10/3/13.
//  Copyright (c) 2013 TYG Digital. All rights reserved.
//

#import "TYGURLManager.h"


@interface TYGURLManager () {
    int taskIdentifier;
    bool isInBackground;
    bool firstBecomeActive;
}

@property int maxSimultaneousLinks;

@property (strong) NSMutableDictionary *urlloaders;

@property (strong) NSMutableArray *queueHigh;
@property (strong) NSMutableArray *queueNormal;
@property (strong) NSMutableArray *queueLow;
@property (strong) NSMutableArray *currentlyLoading;

@property (strong) NSMutableArray *backgroundqueue; //stores all URLs that are not loaded when the app goes into the background.
@property (strong) NSMutableDictionary *urlLoadersWithResultBlocksInBackground;

@end


@implementation TYGURLManager





+(instancetype)instance {
    static TYGURLManager* manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[TYGURLManager alloc] init];
    });
    
   
    
    return manager;
}


-(instancetype)init {
    self = [super init];
    
    self.urlloaders = [[NSMutableDictionary alloc] init];
    //self.queue = [[NSMutableArray alloc] init];
    self.queueHigh = [[NSMutableArray alloc] init];
    self.queueNormal = [[NSMutableArray alloc] init];
    self.queueLow = [[NSMutableArray alloc] init];
    self.currentlyLoading = [[NSMutableArray alloc] init];
    self.backgroundqueue = [[NSMutableArray alloc] init];
    self.urlLoadersWithResultBlocksInBackground = [[NSMutableDictionary alloc] init];
    
    self.maxSimultaneousLinks = TYGURLMaxSimultaneousLinks;
    
    firstBecomeActive = true;
    taskIdentifier = UIBackgroundTaskInvalid;
    isInBackground = false;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecameInactive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecameActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    return self;
}





-(void)addLoader:(TYGURLLoader *)loader {
    //this function does not actually start up the loader, it just adds it to the list of loaders. Use this.requestLoaderStart to actually begin a load.
    
    NSString *url = loader.URL;
    
    //NSLog(@"adding loader %@", loader.URL);
    
    TYGURLLoader* t = self.urlloaders[url];
    if (t != nil) {
        //The URL you are trying to load is already being loaded. Decide what you want to do in this case. You can either cancel the existing one, or not start the new one, or have them exist side by side. There are pros and cons to each approach. Should an option dictate how to resolve this conflict?
        //TODO: solve the conflict by making not one onComplete/Fail/Progress, but an array of them. That way, multiple requests for the same URL are actually pointing to the same object.
        //[t stopAndRemove:true];
        NSLog(@"loader %@ already exists", loader.URL);
        return;
    }
    
    self.urlloaders[url] = loader;
    
}
-(void)removeLoader:(TYGURLLoader *)loader {
    
    NSString *url = loader.URL;
    
    [self.urlloaders removeObjectForKey:url];
    
}

//returns a loader if it exists. Otherwise, returns nil.
-(TYGURLLoader*)existingLoaderWithURL:(NSString *)urlString {
    //NSLog(@"request existing loader with url %@", urlString);
    return self.urlloaders[urlString];
}

-(void)requestLoaderStart:(TYGURLLoader *)loader {
    
    if ([self.currentlyLoading containsObject:loader]) {
        
        [self updateCurrentQueue];
        
    } else if (loader.priority == TYGURLPriorityStartImmediately) {
        
        [self startSingleLoader:loader];
        [self updateCurrentQueue];
        
        
    } else {
        
        
        NSMutableArray *q = [self getQueueForPrio:loader.priority];
        if ([q containsObject:loader] == false) {
            if (loader.priority & TYGURLFrontOfQueueBit) {
                [q insertObject:loader atIndex:0];
            } else {
                [q addObject:loader];
            }
            
            [self updateCurrentQueue];
        }
        
    }
    
    
}

-(void)loaderCompleted:(TYGURLLoader *)loader {
    loader.inQueue = 0;
    [self.currentlyLoading removeObject:loader];
    [self updateCurrentQueue];
}
-(void)loaderCancelled:(TYGURLLoader *)loader {
    loader.inQueue = 0;
    [self.currentlyLoading removeObject:loader];
    [[self getQueueForPrio:loader.priority] removeObject:loader];
    
    [self updateCurrentQueue];
}


//internal helper function
-(NSMutableArray*)getQueueForPrio:(TYGURLPriority)priority {
    if (priority & TYGURLQueueBitLow) return self.queueLow;
    if (priority & TYGURLQueueBitNormal) return self.queueNormal;
    if (priority & TYGURLQueueBitHigh) return self.queueHigh;
    if (priority & TYGURLQueueBitImmediately) return nil; //potentially return self.currentlyLoading here;
    return nil;
}
//internal helper function
-(int)allQueuesCount {
    int i = 0;
    i += self.queueHigh.count;
    i += self.queueNormal.count;
    i += self.queueLow.count;
    return i;
}



-(BOOL)loaderShouldExecuteBlockImmediately:(TYGURLLoader *)loader {
    if (isInBackground == false) return YES;
    
    self.urlLoadersWithResultBlocksInBackground[loader.URL] = loader;
    
    return TYGURLLoadInBackgroundDefaultSetting;
}




-(void)updateCurrentQueue {
    TYGURLLoader *loader;
    
    //NSLog(@"updatING current queue %i %i %i", self.currentlyLoading.count, [self allQueuesCount], self.urlloaders.count);
    
    
    
    while (self.currentlyLoading.count < self.maxSimultaneousLinks) {
        /*if ([self allQueuesCount] == 0) {
            break;
        };*/
        
        if (self.queueHigh.count > 0) {
            loader = self.queueHigh[0];
        } else if (self.queueNormal.count > 0) {
            loader = self.queueNormal[0];
        } else if (self.queueLow.count > 0) {
            loader = self.queueLow[0];
        } else {
            break;
        }
        
        
        
        [self startSingleLoader:loader];
        
    }
    
    
    
    //NSLog(@"updatED current queue %i %i %i", self.currentlyLoading.count, [self allQueuesCount], self.urlloaders.count);
    
    [self checkAndUpdateBackgroundTaskStatus];
}

-(void)startSingleLoader:(TYGURLLoader*)loader {
    [[self getQueueForPrio:loader.priority] removeObject:loader];
    [self.currentlyLoading addObject:loader];
    loader.inQueue = 1;
    [loader start];
    //NSLog(@"starting loader %@", loader.URL);
}

-(void)checkAndUpdateBackgroundTaskStatus {
    
    
    if (self.currentlyLoading.count == 0 && taskIdentifier != UIBackgroundTaskInvalid) {
        //NSLog(@"end bg task");
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        [[UIApplication sharedApplication] endBackgroundTask:taskIdentifier];
        taskIdentifier = UIBackgroundTaskInvalid;
        return;
    }
    
    
    if (taskIdentifier != UIBackgroundTaskInvalid) return;
    if (isInBackground == true) return;
    if (self.currentlyLoading.count == 0) return;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //NSLog(@"starting bg task");
    
    taskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^() {
        //this function is called when the background time has ran out. This should cancel all active connections.
        //NSLog(@"cancelling url loaders");
        [self cancelCurrentlyActiveLoaders];
        
    }];
}

-(void)cancelCurrentlyActiveLoaders {
    TYGURLLoader *t;
    while (self.currentlyLoading.count > 0) {
        t = [self.currentlyLoading lastObject];
        
        t.inQueue = 0;
        [t closeURLConnection];
        
        [self.currentlyLoading removeLastObject];
        [[self getQueueForPrio:t.priority] insertObject:t atIndex:0];
    }
    
    //this cancels the background task.
    [[UIApplication sharedApplication] endBackgroundTask:taskIdentifier];
    taskIdentifier = UIBackgroundTaskInvalid;
}


-(void)determineLoadersToLoadInBackground {
    [self putQueueInBackgroundQueue:self.queueHigh];
    [self putQueueInBackgroundQueue:self.queueNormal];
    [self putQueueInBackgroundQueue:self.queueLow];
    
    NSLog(@"determineLoadersToLoadInBackground: %i %i %i", self.currentlyLoading.count, [self allQueuesCount], self.backgroundqueue.count);
}
-(void)putQueueInBackgroundQueue:(NSMutableArray*)queue {
    TYGURLLoader *t;
    for (int i = 0; i < queue.count; i++) {
        t = queue[i];
        
        BOOL loadInBG = [t shouldLoadInBackground];
        
        if (loadInBG == true) continue;
        
        [self.backgroundqueue addObject:t];
        [queue removeObjectAtIndex:i];
        i--;
    }
}

-(void)mergeBackgroundQueueAndNormalQueue {
    TYGURLLoader *t;
    
    //1. merge backgroundqueue and queue;  2. run complete/fail blocks
    
    //1.
    for (int i = 0; i < self.backgroundqueue.count; i++) {
        t = self.backgroundqueue[i];
        [[self getQueueForPrio:t.priority] addObject:t];
    }
    
    [self.backgroundqueue removeAllObjects];
    
    NSLog(@"mergeBackgroundQueueAndNormalQueue: %i %i %i", self.currentlyLoading.count, [self allQueuesCount], self.backgroundqueue.count);
    
    //2.
    NSArray *a = [self.urlLoadersWithResultBlocksInBackground allValues];
    for (int i = 0; i < a.count; i++) {
        t = a[i];
        [t executeCompletionBlocks];
    }
    
    [self.urlLoadersWithResultBlocksInBackground removeAllObjects];
}





-(void)appBecameInactive:(NSNotification*)notification {
    isInBackground = true;
    
    [self determineLoadersToLoadInBackground];
    //[self cancelCurrentlyActiveLoaders];
}


-(void)appBecameActive:(NSNotification*)notification {
    isInBackground = false;
    
    if (firstBecomeActive == true) {
        firstBecomeActive = false;
        return;
    }
    
    
    [self mergeBackgroundQueueAndNormalQueue];
    [self updateCurrentQueue];
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
