//
//  SSMacros.m
//  soselfie
//
//  Created by TYG on 04/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "SSMacros.h"

@implementation SSMacros

static int devicetype = INT_MAX;

+(SSDeviceType)deviceType {
    if (devicetype == INT_MAX) devicetype = GET_DEVICE_TYPE;
    return devicetype;
}

@end
