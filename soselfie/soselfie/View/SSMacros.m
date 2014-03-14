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

+(UIColor *)colorNormalForVoteType:(SSVoteType)voteType {
    if (voteType == SSVoteTypeFunny) return [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
    if (voteType == SSVoteTypeHot) return [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    if (voteType == SSVoteTypeLame) return [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
    if (voteType == SSVoteTypeTryAgain) return [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
    return nil;
}
+(UIColor *)colorHighlightedForVoteType:(SSVoteType)voteType {
    if (voteType == SSVoteTypeFunny) return [UIColor colorWithRed:(197/255.0) green:(229/255.0) blue:(62/255.0) alpha:1];
    if (voteType == SSVoteTypeHot) return [UIColor colorWithRed:(252/255.0) green:(96/255.0) blue:(152/255.0) alpha:1];
    if (voteType == SSVoteTypeLame) return [UIColor colorWithRed:(13/255.0) green:(198/255.0) blue:(255/255.0) alpha:1];
    if (voteType == SSVoteTypeTryAgain) return [UIColor colorWithRed:(111/255.0) green:(58/255.0) blue:(173/255.0) alpha:1];
    return nil;
}


@end
