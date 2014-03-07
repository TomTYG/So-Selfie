//
//  SSButton.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 07/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "SSButton.h"

@implementation SSButton

//this class is here purely to artificially and automatically increase the tap radius of buttons.

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //increase this number to increase the hit radius of all TWButtons.
    CGFloat margin = 20.0;
    CGRect area = CGRectInset(self.bounds, -margin, -margin);
    return CGRectContainsPoint(area, point);
}

@end
