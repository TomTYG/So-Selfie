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
    
    self.frame = CGRectMake(0, 0, 320, 64);
    
    float MARGIN = 8;
    //BOOL b = GET_DEVICE_TYPE == SSDeviceTypeiPhone5;
    BOOL b = IS_IOS7;
    
    if (b == false) {
        CGRect cr = self.frame;
        cr.size.height -= 20;
        self.frame = cr;
    }
    
    self.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
    
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (b ? 10 : 2), self.frame.size.width,self.frame.size.height)];
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    self.headerLabel.textColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:119/255.0 alpha:1.0];
    self.headerLabel.backgroundColor = [UIColor clearColor];
    self.headerLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:20];
    [self addSubview:self.headerLabel];
    self.headerLabel.userInteractionEnabled = YES;
    
    //add filter button
    float width = 90;
    
    //if (b == true && (GET_DEVICE_TYPE != SSDeviceTypeiPhone5)) {
    
    
    //float height = b == true ? 20 : 14;
    float height = 0.5 * (self.frame.size.height + (b ? 20 : 0)) - 0.5 * 32;
    
    
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
    [self.mainMenuButton setFrame:CGRectMake (MARGIN, height, 32, 32)];
    [self.mainMenuButton setBackgroundImage:[UIImage imageNamed:@"slidebutton"] forState:UIControlStateNormal];
    [self.mainMenuButton setBackgroundImage:[UIImage imageNamed:@"slidebutton"] forState:UIControlStateHighlighted | UIControlStateSelected];
    [self.mainMenuButton addTarget:self
                            action:@selector(callShowSwipeMenuMethod:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mainMenuButton];
    
    
    
    
    width = 140;
    CGRect cr = CGRectMake(self.mainMenuButton.frame.origin.x + self.mainMenuButton.frame.size.width + MARGIN, height, width, 32);
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    [data addObject:@{@"name": @"top all time",
                      @"color" : [SSMacros colorNormalForVoteType:SSVoteTypeTryAgain],
                      @"colorHighlighted" : [SSMacros colorHighlightedForVoteType:SSVoteTypeTryAgain],
                      @"datetype" : @(SSDateTypeAll)}];
    [data addObject:@{@"name": @"top this month",
                      @"color" : [SSMacros colorNormalForVoteType:SSVoteTypeFunny],
                      @"colorHighlighted" : [SSMacros colorHighlightedForVoteType:SSVoteTypeFunny],
                      @"datetype" : @(SSDateTypeLastMonth)}];
    [data addObject:@{@"name": @"top this week",
                      @"color" : [SSMacros colorNormalForVoteType:SSVoteTypeLame],
                      @"colorHighlighted" : [SSMacros colorHighlightedForVoteType:SSVoteTypeLame],
                      @"datetype" : @(SSDateTypeLastWeek)}];
    [data addObject:@{@"name": @"top today",
                      @"color" : [SSMacros colorNormalForVoteType:SSVoteTypeHot],
                      @"colorHighlighted" : [SSMacros colorHighlightedForVoteType:SSVoteTypeHot],
                      @"datetype" : @(SSDateTypeLastDay)}];
    
    self.dropDownViewDateType = [[SSDropDownView alloc] initWithFrame:cr andCellSize:CGSizeMake(width, 40) andNameAndColorsArray:data];
    self.dropDownViewDateType.delegate = self;
    [self addSubview:self.dropDownViewDateType];
    self.dropDownViewDateType.hidden = YES;
    
    
    
    
    data = [[NSMutableArray alloc] init];
    [data addObject:@{@"name": @"SO funny!",
                      @"color" : [SSMacros colorNormalForVoteType:SSVoteTypeFunny],
                      @"colorHighlighted" : [SSMacros colorHighlightedForVoteType:SSVoteTypeFunny],
                      @"votetype" : @(SSVoteTypeFunny)}];
    [data addObject:@{@"name": @"SO hot!",
                      @"color" : [SSMacros colorNormalForVoteType:SSVoteTypeHot],
                      @"colorHighlighted" : [SSMacros colorHighlightedForVoteType:SSVoteTypeHot],
                      @"votetype" : @(SSVoteTypeHot)}];
    [data addObject:@{@"name": @"SO lame!",
                      @"color" : [SSMacros colorNormalForVoteType:SSVoteTypeLame],
                      @"colorHighlighted" : [SSMacros colorHighlightedForVoteType:SSVoteTypeLame],
                      @"votetype" : @(SSVoteTypeLame)}];
    [data addObject:@{@"name": @"SO weird!",
                      @"color" : [SSMacros colorNormalForVoteType:SSVoteTypeTryAgain],
                      @"colorHighlighted" : [SSMacros colorHighlightedForVoteType:SSVoteTypeTryAgain],
                      @"votetype" : @(SSVoteTypeTryAgain)}];
    
    width = self.frame.size.width - 2 * MARGIN - (self.dropDownViewDateType.frame.origin.x + self.dropDownViewDateType.frame.size.width);
    cr.origin.x = self.frame.size.width - width - MARGIN;
    cr.size.width = width;
    self.dropDownViewVoteType = [[SSDropDownView alloc] initWithFrame:cr andCellSize:CGSizeMake(width, 40) andNameAndColorsArray:data];
    self.dropDownViewVoteType.delegate = self;
    [self addSubview:self.dropDownViewVoteType];
    self.dropDownViewVoteType.hidden = YES;
    
    
    return self;
}


//this method is here because the drop down menu might extend beyond the bounds of the TabBarView, and we don't want to inflate the entire view, or use other object's views or something.
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (CGRectContainsPoint(self.dropDownViewDateType.frame, point)) return YES;
    if (CGRectContainsPoint(self.dropDownViewVoteType.frame, point)) return YES;
    
    return [super pointInside:point withEvent:event];
}

-(void)closeAllDropDownMenus {
    [self.dropDownViewDateType setDropDownMenuVisibility:NO instant:NO];
    [self.dropDownViewVoteType setDropDownMenuVisibility:NO instant:NO];
}
-(void)dropDownView:(SSDropDownView *)dropDownView clickedIndex:(int)index {
    
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

@end
