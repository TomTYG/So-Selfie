//
//  SSMacros.h
//  soselfie
//
//  Created by TYG on 04/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSMacros : NSObject

#define IS_IOS7  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define iOS7_OFFSET ( ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) ? 20 : 0)

typedef NS_ENUM(NSInteger, SSDeviceType) {
    SSDeviceTypeUnknown = -1,
    SSDeviceTypeiPhone = 0,
    SSDeviceTypeiPhone5 = 1,
    SSDeviceTypeiPad = 2
};

#define GET_DEVICE_TYPE ([UIScreen mainScreen].bounds.size.height == 480 ? SSDeviceTypeiPhone : [UIScreen mainScreen].bounds.size.height == 568 ? SSDeviceTypeiPhone5 : [UIScreen mainScreen].bounds.size.height == 1024 ? SSDeviceTypeiPad : SSDeviceTypeUnknown)

+(SSDeviceType)deviceType;

@end
