//
//  TYGURL.h
//
//  Created by Tom van Kruijsbergen on 10/3/13.
//  Copyright (c) 2013 TYG Digital. All rights reserved.
//


//Umbrella file for the TYG Loader. When you want your app to use the library, just import this file.


typedef NS_ENUM(unsigned int, TYGURLMethod) {
    TYGURLMethodGet = 0,
    TYGURLMethodPost
};

#define TYGURLMaxSimultaneousLinks 8
#define TYGURLLoadInBackgroundDefaultSetting YES; //if this is YES, all URLs will continue to load in the background by default unless explicitly told not to. If this is NO, nothing will load in the background, unless explicitly told to.

#define TYGURLFrontOfQueueBit 1 << 1
#define TYGURLQueueBitLow 1 << 2
#define TYGURLQueueBitNormal 1 << 3
#define TYGURLQueueBitHigh 1 << 4
#define TYGURLQueueBitImmediately 1 << 5

typedef NS_ENUM(unsigned int, TYGURLPriority) {
    TYGURLPriorityLowBack = TYGURLQueueBitLow,
    TYGURLPriorityLowFront = TYGURLQueueBitLow | TYGURLFrontOfQueueBit,
    TYGURLPriorityNormalBack = TYGURLQueueBitNormal,
    TYGURLPriorityNormalFront = TYGURLQueueBitNormal | TYGURLFrontOfQueueBit,
    TYGURLPriorityHighBack = TYGURLQueueBitHigh,
    TYGURLPriorityHighFront = TYGURLQueueBitHigh | TYGURLFrontOfQueueBit,
    TYGURLPriorityStartImmediately = TYGURLQueueBitImmediately
};



#define TYGURLBackgroundFunctionYES ^BOOL (TYGURLLoader *loader) { return YES; }
#define TYGURLBackgroundFunctionNO ^BOOL (TYGURLLoader *loader) { return NO; }



#import "TYGURLLoader.h"
#import "TYGURLManager.h"



@protocol TYGURLLoaderDelegate <NSObject>

@optional
-(BOOL)urlLoaderShouldLoadInBackground:(TYGURLLoader*)loader;

@end