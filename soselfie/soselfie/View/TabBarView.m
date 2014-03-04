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
    if (self) {
        
        //add header label
        
        //iphone 4 or 5
        
        if ([SSMacros deviceType] == SSDeviceTypeiPhone5){
        self.frame = CGRectMake(0, 0, 320, 60);
        }
        else{
            
        self.frame = CGRectMake(0, 0, 320, 60);
        }
        
        self.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
        
        self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 320,60)];
        self.headerLabel.textAlignment = NSTextAlignmentCenter;
        self.headerLabel.textColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:119/255.0 alpha:1.0];
        self.headerLabel.backgroundColor = [UIColor clearColor];
        self.headerLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:20];
        [self addSubview:self.headerLabel];
        self.headerLabel.userInteractionEnabled = YES;
        
        //add filter button
        
        self.filterButton = [[UIButton alloc] initWithFrame:CGRectMake (215, 20, 100, 32)];
        self.filterButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:15];
        [self.filterButton setTitle:@"so funny" forState:UIControlStateNormal];
        [self.filterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.filterButton.backgroundColor = [UIColor colorWithRed:176/255.0 green:208/255.0 blue:53/255.0 alpha:1.0];
        [self addSubview:self.filterButton];
        
        self.filterButton.hidden = YES;
        
        //add shoot button
        
        self.shootButton = [[UIButton alloc] initWithFrame:CGRectMake(248, 20, 67, 32)];
        self.shootButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:15];
        [self.shootButton setTitle:@"shoot" forState:UIControlStateNormal];
        [self.shootButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.shootButton.backgroundColor = [UIColor colorWithRed:176/255.0 green:208/255.0 blue:53/255.0 alpha:1.0];
        
        [self.shootButton addTarget:self action:@selector(shootButtonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.shootButton];
        
        self.shootButton.hidden = YES;
        
        // add vote button
        
        self.voteButton = [[UIButton alloc] initWithFrame:CGRectMake(248, 20, 67, 32)];
        self.voteButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:15];
        [self.voteButton setTitle:@"vote" forState:UIControlStateNormal];
        [self.voteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.voteButton.backgroundColor = [UIColor colorWithRed:176/255.0 green:208/255.0 blue:53/255.0 alpha:1.0];
        [self.voteButton addTarget:self action:@selector(voteButtonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.voteButton];
        
        self.voteButton.hidden = YES;
        
        //add main slidebutton
        
        self.mainMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mainMenuButton setFrame:CGRectMake (5, 20, 32, 32)];
        [self.mainMenuButton setBackgroundImage:[UIImage imageNamed:@"slidebutton"] forState:UIControlStateNormal];
        [self.mainMenuButton setBackgroundImage:[UIImage imageNamed:@"slidebutton"] forState:UIControlStateHighlighted | UIControlStateSelected];
        [self.mainMenuButton addTarget:self
                                           action:@selector(callShowSwipeMenuMethod:)
                                 forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:self.mainMenuButton];
        
        //add transperent pan gesture recognizer
        
     
        }
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
