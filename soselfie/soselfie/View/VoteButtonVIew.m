//
//  VoteButtonVIew.m
//  SoSelfie
//
//  Created by TYG on 27/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "VoteButtonView.h"

@implementation VoteButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
        
    
    //sofunnybutton
    self.soFunnyButton = [RankingButtonWithSubtitle buttonWithType:UIButtonTypeCustom];
    [self.soFunnyButton setTitle:@"SO funny!" forState:UIControlStateNormal];
    self.soFunnyButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
    
    [self.soFunnyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.soFunnyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.soFunnyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    //iphone 4 or 5
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
        self.soFunnyButton.frame = CGRectMake(0, 0, 160, 95);
    }
    
    else{
        //NSLog (@"now this one is the frame");
        self.soFunnyButton.frame = CGRectMake(0, 0, 160, 60);
    }
    
    [self.soFunnyButton addTarget:self
                           action:@selector(soFunnyButtonWasPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
    self.soFunnyButton.backgroundColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
    [self.soFunnyButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(197/255.0) green:(229/255.0) blue:(62/255.0) alpha:1]] forState:UIControlStateHighlighted];
    [self.soFunnyButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(197/255.0) green:(229/255.0) blue:(62/255.0) alpha:1]] forState:UIControlStateSelected];
    [self addSubview:self.soFunnyButton];
    
    //sohotbutton
    self.soHotButton = [RankingButtonWithSubtitle buttonWithType:UIButtonTypeCustom];
    [self.soHotButton setTitle:@"SO hot!" forState:UIControlStateNormal];
    self.soHotButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
    
    [self.soHotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.soHotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.soHotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self.soHotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //iphone 4 or 5
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
        self.soHotButton.frame = CGRectMake(160, 0, 160, 95);
    }
    
    else{
        //NSLog (@"now this one is the frame");
        self.soHotButton.frame = CGRectMake(160, 0, 160, 60);
    }
    
    [self.soHotButton addTarget:self
                         action:@selector(soHotButtonWasPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    self.soHotButton.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    [self.soHotButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(252/255.0) green:(96/255.0) blue:(152/255.0) alpha:1]] forState:UIControlStateHighlighted];
    [self.soHotButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(252/255.0) green:(96/255.0) blue:(152/255.0) alpha:1]] forState:UIControlStateSelected];
    [self addSubview:self.soHotButton];
    
    //solamebutton
    self.soLameButton = [RankingButtonWithSubtitle buttonWithType:UIButtonTypeCustom];
    [self.soLameButton setTitle:@"SO lame!" forState:UIControlStateNormal];
    self.soLameButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
    
    [self.soLameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.soLameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.soLameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self.soLameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //iphone 4 or 5
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
        self.soLameButton.frame = CGRectMake(0, 95, 160, 95);
    }
    
    else{
        //NSLog (@"now this one is the frame");
        self.soLameButton.frame = CGRectMake(0, 60, 160, 60);
    }
    
    [self.soLameButton addTarget:self
                          action:@selector(soLameButtonWasPressed:)
                forControlEvents:UIControlEventTouchUpInside];
    self.soLameButton.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
    [self.soLameButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(13/255.0) green:(198/255.0) blue:(255/255.0) alpha:1]] forState:UIControlStateHighlighted];
    [self.soLameButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(13/255.0) green:(198/255.0) blue:(255/255.0) alpha:1]] forState:UIControlStateSelected];
    [self addSubview:self.soLameButton];
    
    //tryAgain
    self.tryAgain = [RankingButtonWithSubtitle buttonWithType:UIButtonTypeCustom];
    [self.tryAgain setTitle:@"SO weird!" forState:UIControlStateNormal];
    self.tryAgain.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
    
    [self.tryAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tryAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.tryAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self.tryAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
        self.tryAgain.frame = CGRectMake(160, 95, 160, 95);
    }
    
    else{
        //NSLog (@"now this one is the frame");
        self.tryAgain.frame = CGRectMake(160, 60, 160, 60);
    }
    
    
    [self.tryAgain addTarget:self
                      action:@selector(tryAgainButtonWasPressed:)
            forControlEvents:UIControlEventTouchUpInside];
    self.tryAgain.backgroundColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
    [self.tryAgain setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(111/255.0) green:(58/255.0) blue:(173/255.0) alpha:1]] forState:UIControlStateHighlighted];
    [self.tryAgain setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(111/255.0) green:(58/255.0) blue:(173/255.0) alpha:1]] forState:UIControlStateSelected];
    [self addSubview:self.tryAgain];
    
    [self disableButtons];
    
    return self;

}

//static NSString *const ratingButtonIsPressed = @"RatingButtonIsPressed";

-(void)soFunnyButtonWasPressed:(id)sender {

    //[[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];
    [self disableButtons];
    //[self disableAllButtonsExceptOne:self.soFunnyButton];
    [self.delegate voteButtonView:self pressedButton:(UIButton*)sender vote:SSVoteTypeFunny];
   
}

-(void)soHotButtonWasPressed:(id)sender {
    //[[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];
    [self disableButtons];
    //[self disableAllButtonsExceptOne:self.soHotButton];
    [self.delegate voteButtonView:self pressedButton:(UIButton*)sender vote:SSVoteTypeHot];
}
        
-(void)soLameButtonWasPressed:(id)sender {
    //[[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];
    [self disableButtons];
    //[self disableAllButtonsExceptOne:self.soLameButton];
    [self.delegate voteButtonView:self pressedButton:(UIButton*)sender vote:SSVoteTypeLame];
}

-(void)tryAgainButtonWasPressed:(id)sender {
    //[[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];
    [self disableButtons];
    //[self disableAllButtonsExceptOne:self.tryAgain];
    [self.delegate voteButtonView:self pressedButton:(UIButton*)sender vote:SSVoteTypeTryAgain];
}



-(void)disableButtons {
    
    self.soFunnyButton.enabled = NO;
    self.soHotButton.enabled = NO;
    self.soLameButton.enabled = NO;
    self.tryAgain.enabled = NO;
    
    self.soFunnyButton.highlighted = NO;
    self.soHotButton.highlighted = NO;
    self.soLameButton.highlighted = NO;
    self.tryAgain.highlighted = NO;
    
    self.soFunnyButton.selected = NO;
    self.soHotButton.selected = NO;
    self.soLameButton.selected = NO;
    self.tryAgain.selected = NO;
    
}


-(void)disableAllButtonsExceptOne:(UIButton *)button {
    
    self.soFunnyButton.enabled = NO;
    self.soHotButton.enabled = NO;
    self.soLameButton.enabled = NO;
    self.tryAgain.enabled = NO;
    
}

-(void)enableButtons {
    self.soFunnyButton.enabled = YES;
    self.soHotButton.enabled = YES;
    self.soLameButton.enabled = YES;
    self.tryAgain.enabled = YES;
}

-(void)startWithVotesDictionary:(NSDictionary *)dictionary {
    [self.soFunnyButton setNumberOfVotes:[dictionary[@"votes_funny"][@"count"] integerValue]];
    [self.soHotButton setNumberOfVotes:[dictionary[@"votes_hot"][@"count"] integerValue]];
    [self.soLameButton setNumberOfVotes:[dictionary[@"votes_lame"][@"count"] integerValue]];
    [self.tryAgain setNumberOfVotes:[dictionary[@"votes_weird"][@"count"] integerValue]];
}
//this is called from the parent view cell just before reusing it and repopulating it with new votes.
-(void)prepareForReuse {
    self.soFunnyButton.subtitleLabel.text = @"";
    self.soHotButton.subtitleLabel.text = @"";
    self.soLameButton.subtitleLabel.text = @"";
    self.tryAgain.subtitleLabel.text = @"";
    
    //[self disableButtons];
    [self enableButtons];
}

@end
