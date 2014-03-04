//
//  SwipeMenuButton.m
//  SoSelfie
//
//  Created by TYG on 21/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "SwipeMenuButton.h"

@implementation SwipeMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:18];
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



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
