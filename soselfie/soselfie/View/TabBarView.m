//
//  TabBarView.m
//  ARSSReader
//
//  Created by TYG on 12/12/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "TabBarView.h"

@implementation TabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.frame = CGRectMake(0, 0, 320, 60);
    
    BOOL b = GET_DEVICE_TYPE == SSDeviceTypeiPhone5;
    
    self.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
    
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, b ? 7 : 3, 320,60)];
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    self.headerLabel.textColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:119/255.0 alpha:1.0];
    self.headerLabel.backgroundColor = [UIColor clearColor];
    self.headerLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:20];
    [self addSubview:self.headerLabel];
    self.headerLabel.userInteractionEnabled = YES;
    
    //add filter button
    float width = 90;
    
    float height = b == true ? 20 : 14;
    
    
    self.filterButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(self.frame.size.width - width - 6, height, width, 32) withBackgroundColor:[UIColor colorWithRed:176/255.0 green:208/255.0 blue:53/255.0 alpha:1.0] highlightColor:[UIColor colorWithRed:(197/255.0) green:(229/255.0) blue:(62/255.0) alpha:1] titleLabel:@"SO funny!" withFontSize:15];
    [self addSubview:self.filterButton];
    self.filterButton.hidden = YES;
    
    //add shoot button
    
    
    self.shootButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(248, height, 67, 32) withBackgroundColor:[UIColor colorWithRed:176/255.0 green:208/255.0 blue:53/255.0 alpha:1.0] highlightColor:[UIColor colorWithRed:(197/255.0) green:(229/255.0) blue:(62/255.0) alpha:1] titleLabel:@"Shoot!" withFontSize:15];
    [self.shootButton addTarget:self action:@selector(shootButtonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shootButton];
    self.shootButton.hidden = YES;
    
    // add vote button
    
    self.voteButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(248, height, 67, 32) withBackgroundColor:[UIColor colorWithRed:176/255.0 green:208/255.0 blue:53/255.0 alpha:1.0] highlightColor:[UIColor colorWithRed:(197/255.0) green:(229/255.0) blue:(62/255.0) alpha:1] titleLabel:@"Vote!" withFontSize:15];
    [self.voteButton addTarget:self action:@selector(voteButtonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.voteButton];
    self.voteButton.hidden = YES;
    
    //add main slidebutton
    
    self.mainMenuButton = [SSButton buttonWithType:UIButtonTypeCustom];
    [self.mainMenuButton setFrame:CGRectMake (5, height, 32, 32)];
    [self.mainMenuButton setBackgroundImage:[UIImage imageNamed:@"slidebutton"] forState:UIControlStateNormal];
    [self.mainMenuButton setBackgroundImage:[UIImage imageNamed:@"slidebutton"] forState:UIControlStateHighlighted | UIControlStateSelected];
    [self.mainMenuButton addTarget:self
                            action:@selector(callShowSwipeMenuMethod:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:self.mainMenuButton];
    
    return self;
}

-(void)callShowSwipeMenuMethod:(id)sender {
    
    static NSString *const menuButtonIsPressed = @"menuButtonIsPressed";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:menuButtonIsPressed object:self];
}

- (void)voteButtonIsPressed:(id)sender {
    
    static NSString *const voteButtonIsPressed = @"voteButtonIsPressed";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:voteButtonIsPressed object:self];
    
}

- (void)shootButtonIsPressed:(id)sender {
    
    static NSString *const shootButtonIsPressed = @"shootButtonIsPressed";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:shootButtonIsPressed object:self];
    
    
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
