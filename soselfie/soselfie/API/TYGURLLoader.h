//
//  TYGURLLoader.h
//  URLLoader1
//
//  Created by Tom van Kruijsbergen on 10/3/13.
//  Copyright (c) 2013 TYG Digital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYGURL.h"


@interface TYGURLLoader : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

+(TYGURLLoader*)handleURL:(NSString*)urlString method:(TYGURLMethod)method options:(NSDictionary*)options onComplete:(void(^)(NSDictionary* data))completionHandler onFail:(void(^)(NSDictionary* data))failureHandler;

@property int inQueue;
@property int status;
@property (strong) NSDictionary *options;
@property (strong) NSString *URL;

-(TYGURLPriority)priority;
-(void)closeURLConnection;
-(void)start;
-(void)stopAndRemove:(BOOL)alsoRemove;
-(BOOL)shouldLoadInBackground;
-(void)executeCompletionBlocks;
-(void)addCompleteBlock:(void(^)(NSDictionary *data))completionHandler andFailureBlock:(void(^)(NSDictionary* data))failureHandler andProgressBlock:(void(^)(NSDictionary *data))progressHandler;

@end




