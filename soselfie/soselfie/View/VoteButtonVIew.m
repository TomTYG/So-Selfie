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
    self.soFunnyButton = [[RankingButtonWithSubtitle alloc] initWithFrame:CGRectMake(0, 0, 160, 95)];
    [self.soFunnyButton setTitle:@"SO funny!" forState:UIControlStateNormal];
    self.soFunnyButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
    [self.soFunnyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.soFunnyButton addTarget:self
                           action:@selector(soFunnyButtonWasPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
    self.soFunnyButton.backgroundColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
    [self addSubview:self.soFunnyButton];
    
    //sohotbutton
    self.soHotButton = [[RankingButtonWithSubtitle alloc] initWithFrame:CGRectMake(160, 0, 160, 95)];
    [self.soHotButton setTitle:@"SO hot!" forState:UIControlStateNormal];
    self.soHotButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
    [self.soHotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.soHotButton addTarget:self
                         action:@selector(soHotButtonWasPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    self.soHotButton.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    [self addSubview:self.soHotButton];
    
    //solamebutton
    self.soLameButton = [[RankingButtonWithSubtitle alloc] initWithFrame:CGRectMake(0, 95, 160, 95)];
    [self.soLameButton setTitle:@"SO lame!" forState:UIControlStateNormal];
    self.soLameButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
    [self.soLameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.soLameButton addTarget:self
                          action:@selector(soLameButtonWasPressed:)
                forControlEvents:UIControlEventTouchUpInside];
    self.soLameButton.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
    [self addSubview:self.soLameButton];
    
    //tryAgain
    self.tryAgain = [[RankingButtonWithSubtitle alloc] initWithFrame:CGRectMake(160, 95, 160, 95)];
    //self.tryAgain = [RankingButtonWithSubtitle buttonWithType:UIButtonTypeRoundedRect];
    [self.tryAgain setTitle:@"SO weird!" forState:UIControlStateNormal];
    self.tryAgain.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
    [self.tryAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tryAgain addTarget:self
                      action:@selector(tryAgainButtonWasPressed:)
            forControlEvents:UIControlEventTouchUpInside];
    self.tryAgain.backgroundColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
    [self addSubview:self.tryAgain];
    
    return self;
}

//static NSString *const ratingButtonIsPressed = @"RatingButtonIsPressed";

-(void)soFunnyButtonWasPressed:(id)sender {
    //[[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];
    [self disableButtons];
    [self.delegate voteButtonView:self pressedButton:(UIButton*)sender vote:SSVoteTypeFunny];
}

-(void)soHotButtonWasPressed:(id)sender {
    //[[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];
    [self disableButtons];
    [self.delegate voteButtonView:self pressedButton:(UIButton*)sender vote:SSVoteTypeHot];
}
        
-(void)soLameButtonWasPressed:(id)sender {
    //[[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];
    [self disableButtons];
    [self.delegate voteButtonView:self pressedButton:(UIButton*)sender vote:SSVoteTypeLame];
}

-(void)tryAgainButtonWasPressed:(id)sender {
    //[[NSNotificationCenter defaultCenter] postNotificationName:ratingButtonIsPressed object:self];
    [self disableButtons];
    [self.delegate voteButtonView:self pressedButton:(UIButton*)sender vote:SSVoteTypeTryAgain];
}

-(void)disableButtons {
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
    [self.soFunnyButton setNumberOfVotes:[dictionary[@"votes_funny"] integerValue]];
    [self.soHotButton setNumberOfVotes:[dictionary[@"votes_hot"] integerValue]];
    [self.soLameButton setNumberOfVotes:[dictionary[@"votes_lame"] integerValue]];
    [self.tryAgain setNumberOfVotes:[dictionary[@"votes_weird"] integerValue]];
}
//this is called from the parent view cell just before reusing it and repopulating it with new votes.
-(void)prepareForReuse {
    self.soFunnyButton.subtitleLabel.text = @"";
    self.soHotButton.subtitleLabel.text = @"";
    self.soLameButton.subtitleLabel.text = @"";
    self.tryAgain.subtitleLabel.text = @"";
    
    [self enableButtons];
}

@end
