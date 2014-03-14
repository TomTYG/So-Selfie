//
//  TopChartCollectionViewLayoutAttributes.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 11/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "TopChartCollectionViewLayoutAttributes.h"

@implementation TopChartCollectionViewLayoutAttributes


- (id)copyWithZone:(NSZone *)zone
{
    //NSLog(@"init topchart attributes");
    TopChartCollectionViewLayoutAttributes *attributes = [super copyWithZone:zone];
    attributes.transformAnimation = _transformAnimation;
    return attributes;
}


- (BOOL)isEqual:(id)other {
    //NSLog(@"is equal %@", other);
    if (other == self) {
        return YES;
    }
    if (!other || ![[other class] isEqual:[self class]]) {
        return NO;
    }
    
    if ([(( TopChartCollectionViewLayoutAttributes *) other) transformAnimation] != [self transformAnimation]) {
        return NO;
    }
    
    return YES;
}

@end
