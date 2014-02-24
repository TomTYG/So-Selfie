//
//  TYGURLManager.h
//  URLLoader1
//
//  Created by Tom van Kruijsbergen on 10/3/13.
//  Copyright (c) 2013 TYG Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TYGURL.h"

@class TYGURLLoader;

@interface TYGURLManager : NSObject

+(TYGURLManager*)instance;

-(TYGURLLoader*)existingLoaderWithURL:(NSString*)urlString;

-(void)addLoader:(TYGURLLoader*)loader;
-(void)removeLoader:(TYGURLLoader*)loader;

-(void)requestLoaderStart:(TYGURLLoader*)loader;
-(void)loaderCompleted:(TYGURLLoader*)loader;
-(void)loaderCancelled:(TYGURLLoader*)loader;


-(BOOL)loaderShouldExecuteBlockImmediately:(TYGURLLoader*)loader;

@end
