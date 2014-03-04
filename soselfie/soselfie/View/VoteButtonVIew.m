//
//  VoteButtonVIew.m
//  SoSelfie
//
//  Created by TYG on 27/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "VoteButtonVIew.h"

@implementation VoteButtonVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        
            
        //sofunnybutton
        self.soFunnyButton = [RankingButtonWithSubtitle buttonWithType:UIButtonTypeCustom];
        [self.soFunnyButton setTitle:@"SO funny!" forState:UIControlStateNormal];
        self.soFunnyButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
        
        [self.soFunnyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.soFunnyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.soFunnyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        self.soFunnyButton.frame = CGRectMake(0, 0, 160, 95);
        [self.soFunnyButton addTarget:self
                               action:@selector(soFunnyButtonWasPressed)
                     forControlEvents:UIControlEventTouchUpInside];
        self.soFunnyButton.backgroundColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
        [self.soFunnyButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(197/255.0) green:(229/255.0) blue:(62/255.0) alpha:1]] forState:UIControlStateHighlighted];
        [self addSubview:self.soFunnyButton];
        
        //sohotbutton
        self.soHotButton = [RankingButtonWithSubtitle buttonWithType:UIButtonTypeCustom];
        [self.soHotButton setTitle:@"SO hot!" forState:UIControlStateNormal];
        self.soHotButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
        
        [self.soHotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.soHotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.soHotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [self.soHotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.soHotButton.frame = CGRectMake(160, 0, 160, 95);
        [self.soHotButton addTarget:self
                             action:@selector(soHotButtonWasPressed)
                   forControlEvents:UIControlEventTouchUpInside];
        self.soHotButton.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
        [self.soHotButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(252/255.0) green:(96/255.0) blue:(152/255.0) alpha:1]] forState:UIControlStateHighlighted];
        [self addSubview:self.soHotButton];
        
        //solamebutton
        self.soLameButton = [RankingButtonWithSubtitle buttonWithType:UIButtonTypeCustom];
        [self.soLameButton setTitle:@"SO lame!" forState:UIControlStateNormal];
        self.soLameButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
        
        [self.soLameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.soLameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.soLameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [self.soLameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.soLameButton.frame = CGRectMake(0, 95, 160, 95);
        [self.soLameButton addTarget:self
                              action:@selector(soLameButtonWasPressed)
                    forControlEvents:UIControlEventTouchUpInside];
        self.soLameButton.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
        [self.soLameButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(13/255.0) green:(198/255.0) blue:(255/255.0) alpha:1]] forState:UIControlStateHighlighted];
        [self addSubview:self.soLameButton];
        
        //tryAgain
        self.tryAgain = [RankingButtonWithSubtitle buttonWithType:UIButtonTypeCustom];
        [self.tryAgain setTitle:@"SO weird!" forState:UIControlStateNormal];
        self.tryAgain.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
        
        [self.tryAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.tryAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.tryAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [self.tryAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.tryAgain.frame = CGRectMake(160, 95, 160, 95);
        [self.tryAgain addTarget:self
                          action:@selector(tryAgainButtonWasPressed)
                forControlEvents:UIControlEventTouchUpInside];
        self.tryAgain.backgroundColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
        [self.tryAgain setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(111/255.0) green:(58/255.0) blue:(173/255.0) alpha:1]] forState:UIControlStateHighlighted];
        [self addSubview:self.tryAgain];
        }
    
    return self;
}


        
-(void)soFunnyButtonWasPressed {
            NSLog (@"SOOO funny!");
    
    static NSString *const ratingButtonIsPressed = @"RatingButtonIsPressed";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];
    
        }
        
-(void)soHotButtonWasPressed {
            NSLog (@"SOOO hot!");
    
    static NSString *const ratingButtonIsPressed = @"RatingButtonIsPressed";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];
    
    
        }
        
-(void)soLameButtonWasPressed {
            NSLog (@"SOOOO lame!");
    
    static NSString *const ratingButtonIsPressed = @"RatingButtonIsPressed";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];
    
        }

-(void)tryAgainButtonWasPressed {
            NSLog (@"Try again!");
    
    static NSString *const ratingButtonIsPressed = @"RatingButtonIsPressed";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];

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
