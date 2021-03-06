//
//  SwipeMenuButton.m
//  SoSelfie
//
//  Created by TYG on 21/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "SwipeMenuButton.h"
#import "SSMacros.h"

@implementation SwipeMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    int fonstSize;
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
    
        fonstSize = 18;
    
    } else {
        
        fonstSize = 16;
        
    }
    
    if (self) {
        self.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:fonstSize];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentEdgeInsets = UIEdgeInsetsMake (0, 10, 0, 0);
        self.backgroundColor = [UIColor clearColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1] forState:UIControlStateSelected];
        
        self.layer.borderWidth = 0.0;
    }
    return self;
}




@end
