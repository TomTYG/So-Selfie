//
//  TYGURLLoader.m
//  URLLoader1
//
//  Created by Tom van Kruijsbergen on 10/3/13.
//  Copyright (c) 2013 TYG Digital. All rights reserved.
//

#import "TYGURLLoader.h"

@interface TYGURLLoader() {
    
    NSMutableData *urldata;
    NSURLConnection *urlconnection;
    NSTimer *timer;
    
    int amountOfTimesToRetry;
    float timeout;
    float timeoutglobal;
    bool cacheResult;
    bool forceReload;
    TYGURLPriority priority;
    
    BOOL stopcalled;
    NSMutableArray *lastUncalledPreviousOrCompleteBlocks;
    NSMutableArray *lastUncalledFailedBlocks;
    
    //NSDictionary *lastUncalledPreviousOrCompleteBlock;
    //NSDictionary *lastUncalledFailedBlock;
    
    NSString* url;
    
    long long expectedContentLength;
}

@property TYGURLMethod method;

@property NSMutableArray *onCompleteBlocks;
@property NSMutableArray *onFailBlocks;
@property NSMutableArray *onProgressBlocks;

//@property (strong) void (^onComplete) (NSDictionary*);
//@property (strong) void (^onFail) (NSDictionary*);
//@property (strong) void (^onProgress) (NSDictionary*);


@property (strong) bool (^shouldRunInBackground) (TYGURLLoader*);

@property (weak) id<TYGURLLoaderDelegate> delegate;


-(void)doInitialConfiguration;

@end



@implementation TYGURLLoader


+(TYGURLLoader*)handleURL:(NSString *)urlString method:(TYGURLMethod)method options:(NSDictionary *)options onComplete:(void (^)(NSDictionary *data))completionHandler onFail:(void (^)(NSDictionary *data))failureHandler {
    
    TYGURLLoader *t = [[TYGURLManager instance] existingLoaderWithURL:urlString];
    
    if (t == nil) {
        
        t = [[TYGURLLoader alloc] init];
        t.options = options;
        t.URL = urlString;
        //t.onComplete = completionHandler;
        //t.onFail = failureHandler;
        t.method = method;
        
        [t addCompleteBlock:completionHandler andFailureBlock:failureHandler andProgressBlock:options[@"onprogress"]];
        
        [[TYGURLManager instance] addLoader:t];
        
        [t doInitialConfiguration];
        
        
    } else {
        
        [t addCompleteBlock:completionHandler andFailureBlock:failureHandler andProgressBlock:options[@"onprogress"]];
        
    }
    
    return t;
}








-(id)init {
    self = [super init];
    
    self.status = 0;
    
    priority = TYGURLPriorityLowBack;
    
    amountOfTimesToRetry = INT_MAX;
    timeout = 15;
    cacheResult = true;
    forceReload = false;
    
    self.inQueue = 0;
    stopcalled = false;
    
    timer = nil;
    
    self.onCompleteBlocks = [[NSMutableArray alloc] init];
    self.onFailBlocks = [[NSMutableArray alloc] init];
    self.onProgressBlocks = [[NSMutableArray alloc] init];
    
    lastUncalledFailedBlocks = [[NSMutableArray alloc] init];
    lastUncalledPreviousOrCompleteBlocks = [[NSMutableArray alloc] init];
    
    return self;
}

-(void)doInitialConfiguration {
    
    //if options.tries == -1, then the object will continue to try to load until cancelled. Use this sparingly!
    if (self.options[@"tries"] != nil) {
        amountOfTimesToRetry = [self.options[@"tries"] integerValue] - 1;
        if ([self.options[@"tries"] integerValue] == -1) amountOfTimesToRetry = INT_MAX;
    }
    
    if (self.options[@"timeout"] != nil) timeout = [self.options[@"timeout"] floatValue];
    
    if (self.options[@"timeoutglobal"] != nil) timeoutglobal = [self.options[@"timeoutglobal"] floatValue];
    
    //if (self.options[@"onprogress"] != nil) self.onProgress = self.options[@"onprogress"];
    
    if (self.options[@"delegate"] != nil && self.options[@"delegate"] != [NSNull null]) self.delegate = self.options[@"delegate"];
    
    if (self.options[@"runinbackgroundfunction"] != nil) self.shouldRunInBackground = self.options[@"runinbackgroundfunction"];
    
    if (self.options[@"cacheresult"] != nil) cacheResult = [self.options[@"cacheresult"] boolValue];
    if (self.options[@"forcereload"] != nil) forceReload = [self.options[@"forcereload"] boolValue];
    
    if (self.method == TYGURLMethodPost) forceReload = true;
    if (self.method == TYGURLMethodPost) cacheResult = false;
    
    if (self.options[@"priority"] != nil) priority = [self.options[@"priority"] integerValue];
    
    bool start = true;
    if (self.options[@"startimmediately"] != nil && [self.options[@"startimmediately"] boolValue] == false) start = false;
    if (start == true) [self start];
    
}

-(void)addCompleteBlock:(void (^)(NSDictionary *))completionHandler andFailureBlock:(void (^)(NSDictionary *))failureHandler andProgressBlock:(void (^)(NSDictionary *))progressHandler {
    
    if (completionHandler != nil) [self.onCompleteBlocks addObject:completionHandler];
    if (failureHandler != nil) [self.onFailBlocks addObject:failureHandler];
    if (progressHandler != nil) [self.onProgressBlocks addObject:progressHandler];
    
    //NSLog(@"%@ %@", self.URL, completionHandler);
}



-(NSString*)URL {
    return url;
}
-(void)setURL:(NSString *)URL {
    if (self.status != 0) return;
    
    url = URL;
}

-(TYGURLPriority)priority {
    return priority;
}




-(void)start {
    
    if ([[NSThread currentThread] isMainThread] == false) {
        [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
        return;
    }
    
    //NSLog(@"start called, status %i %i", self.status, self.inQueue);
    
    NSMutableURLRequest* r = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.URL]];
    r.timeoutInterval = timeout;
    r.HTTPMethod = self.method == TYGURLMethodGet ? @"GET" : @"POST";
    if (self.method == TYGURLMethodPost) {
        r.HTTPBody = self.options[@"postdata"];
        NSString *postLength = [NSString stringWithFormat:@"%d", r.HTTPBody.length];
        [r setValue:postLength forHTTPHeaderField:@"Content-Length"];
    }
    
    if (forceReload == true) {
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:r];
    }
    
    //the if-statement is necessary because getting a cached response for a POST-body results in an error in NSURLCache.
    if (self.method == TYGURLMethodGet) {
        NSCachedURLResponse *rr = [[NSURLCache sharedURLCache] cachedResponseForRequest:r];
        if (rr != nil) {
            //the content you want to load has already been loaded before, and is in the cache. self connection complete calls TYGURLManager.instance.loaderComplete(), so that this loader is also removed.
            urldata = [rr.data copy];
            [self connectionComplete];
            return;
        }
    }
    
    
    
    
    if (self.inQueue == 0) {
        //NSLog(@"added to queue %@", self.URL);
        [[TYGURLManager instance] requestLoaderStart:self];
        return;
    }
    
    self.status = 1;
    
    stopcalled = false;
    
    
    
    
    
    
    
    if (urlconnection != nil) {
        [urlconnection cancel];
        urlconnection = nil;
    }
    
    
    
    urlconnection = [[NSURLConnection alloc] initWithRequest:r delegate:self startImmediately:NO];
    
    urldata = [[NSMutableData alloc] init];
    
    [urlconnection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [urlconnection start];
    
    
}

-(NSCachedURLResponse*)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    //NSLog(@"cached response %i %lu", cachedResponse.storagePolicy, (unsigned long)cachedResponse.data.length);
    if(cacheResult == true) {
        NSCachedURLResponse *r = [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response data:cachedResponse.data userInfo:cachedResponse.userInfo storagePolicy:NSURLCacheStorageAllowed];
        
        [[NSURLCache sharedURLCache] storeCachedResponse:r forRequest:connection.originalRequest];
        
        /*
        NSURLCache *c = [NSURLCache sharedURLCache];
        NSLog(@"cache %lu %lu %lu %lu", (unsigned long)c.currentMemoryUsage, (unsigned long)c.memoryCapacity, (unsigned long)c.currentDiskUsage, (unsigned long)c.diskCapacity);
         */
    }
    return nil;
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [urldata appendData:data];
    
    
    //NSLog(@"received data. new length %lu", (unsigned long)urldata.length);
    if (self.onProgressBlocks.count == 0) return;
    //if (self.onProgress == nil) return;
    
    [lastUncalledPreviousOrCompleteBlocks removeAllObjects];
    
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    
    d[@"urlloader"] = self;
    d[@"bytesloaded"] = [NSNumber numberWithLong:urldata.length];
    d[@"bytestotal"] = [NSNumber numberWithLongLong:expectedContentLength];
    d[@"percentage"] = [NSNumber numberWithFloat:(double)urldata.length / (double)expectedContentLength];
    
    BOOL runBlock = [[TYGURLManager instance] loaderShouldExecuteBlockImmediately:self];
    
    
    
    for (int i = 0; i < self.onProgressBlocks.count; i++) {
        
        void (^onProgress)(NSDictionary*) = self.onProgressBlocks[i];
        
        if (runBlock == true) {
            onProgress(d);
            //self.onProgress(d);
        } else {
            NSDictionary *f = @{@"block": onProgress,
                                @"data" : d};
            [lastUncalledPreviousOrCompleteBlocks addObject:f];
            
            /*lastUncalledPreviousOrCompleteBlock = @{@"block": self.onProgress,
                                                    @"data" : d};*/
        }
    }
    
    
    
};


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    
    [self closeURLConnection];
    
    [lastUncalledFailedBlocks removeAllObjects];
    
    NSDictionary *d = @{@"error": error,
                        @"triesleft" : [NSNumber numberWithInt:amountOfTimesToRetry],
                        @"urlloader" : self};
    
    BOOL runBlock = [[TYGURLManager instance] loaderShouldExecuteBlockImmediately:self];
    
    for (int i = 0; i < self.onFailBlocks.count; i++) {
        
        void (^onFail)(NSDictionary*) = self.onFailBlocks[i];
        
        if (runBlock == true) {
            onFail(d);
        } else {
            /*lastUncalledFailedBlock = @{@"block": self.onFail,
                                        @"data" : d};*/
            NSDictionary *f = @{@"block": onFail,
                                @"data" : d};
            [lastUncalledFailedBlocks addObject:f];
            
        }
        
    }
    
    
    
    
    
    //this can be true if the failure block calls [self stopAndRemove:] on this object. if it's already removed, we don't want to call remove twice.
    if (stopcalled == true) return;
    
    if (amountOfTimesToRetry > 0) {
        amountOfTimesToRetry--;
        
        [self start];
        
    } else {
        [self stopAndRemove:true];
    }
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSHTTPURLResponse *h = (NSHTTPURLResponse*)response;
    if (h.statusCode >= 400) {
        //NSLog(@"connection failed %i", h.statusCode);
        [self connection:urlconnection didFailWithError:[NSError errorWithDomain:@"TYG URL Loader Error" code:h.statusCode userInfo:nil]];
        [self stopAndRemove:true];
        return;
    }
    
    expectedContentLength = 1;
    if (response.expectedContentLength) expectedContentLength = response.expectedContentLength;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [self connectionComplete];
    
}

-(void)connectionComplete {
    self.status = 3;
    
    //NSLog(@"connection complete %@ %i %i", self.URL, self.onCompleteBlocks.count, lastUncalledPreviousOrCompleteBlocks.count);
    
    [lastUncalledPreviousOrCompleteBlocks removeAllObjects];
    [lastUncalledFailedBlocks removeAllObjects];
    
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    d[@"data"] = urldata;
    d[@"urlloader"] = self;
    
    BOOL runBlock = [[TYGURLManager instance] loaderShouldExecuteBlockImmediately:self];
    
    for (int i = 0; i < self.onCompleteBlocks.count; i++) {
        
        void (^onComplete)(NSDictionary*) = self.onCompleteBlocks[i];
        
        if (runBlock == true) {
            onComplete(d);
        } else {
            
            NSDictionary *f = @{@"block": onComplete,
                                @"data" : d};
            [lastUncalledPreviousOrCompleteBlocks addObject:f];
        }
    }
    
    
    
    
    [[TYGURLManager instance] loaderCompleted:self];
    
    [self stopAndRemove:true];
}

-(void)closeURLConnection {
    self.status = 0;
    [urlconnection cancel];
    urlconnection = nil;
}


-(BOOL)shouldLoadInBackground {
    //this tries either a delegate or a completion block to determine whether the link should keep loading in the background. If none are found, it just returns false.
    
    if (self.shouldRunInBackground) {
        return self.shouldRunInBackground(self);
    }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(urlLoaderShouldLoadInBackground:)]) {
        return [self.delegate urlLoaderShouldLoadInBackground:self];
    }
    
    return false;
}
 
-(void)executeCompletionBlocks {
    void (^block) (NSDictionary*);
    NSDictionary *data;
    NSDictionary *entry;
    
    for (int i = 0; i < lastUncalledFailedBlocks.count; i++) {
        entry = lastUncalledFailedBlocks[i];
        block = entry[@"block"];
        data = entry[@"data"];
        
        block(data);
    }
    for (int i = 0; i < lastUncalledPreviousOrCompleteBlocks.count; i++) {
        entry = lastUncalledPreviousOrCompleteBlocks[i];
        block = entry[@"block"];
        data = entry[@"data"];
        
        block(data);
    }
    
    [lastUncalledFailedBlocks removeAllObjects];
    [lastUncalledPreviousOrCompleteBlocks removeAllObjects];
    
    /*
    if (lastUncalledFailedBlock) {
        block = lastUncalledFailedBlock[@"block"];
        data = lastUncalledFailedBlock[@"data"];
        
        block(data);
    }
    if (lastUncalledPreviousOrCompleteBlock ) {
        block = lastUncalledPreviousOrCompleteBlock[@"block"];
        data = lastUncalledPreviousOrCompleteBlock[@"data"];
        
        block(data);
    }
    */
    //lastUncalledFailedBlock = nil;
    //lastUncalledPreviousOrCompleteBlock = nil;
    
   
}




-(void)stopAndRemove:(BOOL)alsoRemove {
    stopcalled = true;
    
    if (self.status == 1) {
        [self closeURLConnection];
        [[TYGURLManager instance] loaderCancelled:self];
    }
    
    if (alsoRemove == true) {
        [[TYGURLManager instance] removeLoader:self];
    }
}


-(void)dealloc {
    self.onCompleteBlocks = nil;
    self.onFailBlocks = nil;
    self.onProgressBlocks = nil;
    
    lastUncalledFailedBlocks = nil;
    lastUncalledPreviousOrCompleteBlocks = nil;
    //self.onComplete = nil;
    //self.onFail = nil;
    //self.onProgress = nil;
}




@end
