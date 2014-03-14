//
//  TopChartCollectionViewFlowLayout.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 11/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "TopChartCollectionViewFlowLayout.h"
#import "TopChartCollectionViewLayoutAttributes.h"

@implementation TopChartCollectionViewFlowLayout

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    //this method is only called on methods that animate, like insertItemsAtIndexPath or deleteItemsAtIndexPath.
    
    
    
    UICollectionViewLayoutAttributes *a = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    //if (a != nil ) NSLog(@"norml attri %@", a);
    
    return a;
    
    
    
    TopChartCollectionViewLayoutAttributes* attributes = (TopChartCollectionViewLayoutAttributes*)[super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.duration = 1.0f;
    CGFloat height = [self collectionViewContentSize].height;
    
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 2*height, height)];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, attributes.bounds.origin.y, 0)];
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.fillMode = kCAFillModeForwards;
    attributes.transformAnimation = transformAnimation;
    //NSLog(@"attributes %i %@", itemIndexPath.item, attributes);
    return attributes;
    
}


@end
