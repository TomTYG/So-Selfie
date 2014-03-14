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
    self.soFunnyButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(0, 0, 0.5 * self.frame.size.width, 0.5 * self.frame.size.height) withBackgroundColor:[SSMacros colorNormalForVoteType:SSVoteTypeFunny] highlightColor:[SSMacros colorHighlightedForVoteType:SSVoteTypeFunny] titleLabel:@"SO funny!" withFontSize:20];
    self.soFunnyButton.titleLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:self.soFunnyButton.titleLabel.font.pointSize];
    [self.soFunnyButton addTarget:self
                           action:@selector(soFunnyButtonWasPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.soFunnyButton];
    
    self.soHotButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(0.5 * self.frame.size.width, 0, 0.5 * self.frame.size.width, 0.5 * self.frame.size.height) withBackgroundColor:[SSMacros colorNormalForVoteType:SSVoteTypeHot] highlightColor:[SSMacros colorHighlightedForVoteType:SSVoteTypeHot] titleLabel:@"SO hot!" withFontSize:20];
    self.soHotButton.titleLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:self.soHotButton.titleLabel.font.pointSize];
    [self.soHotButton addTarget:self
                           action:@selector(soHotButtonWasPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.soHotButton];
    
    self.soLameButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(0, 0.5 * frame.size.height, 0.5 * self.frame.size.width, 0.5 * self.frame.size.height) withBackgroundColor:[SSMacros colorNormalForVoteType:SSVoteTypeLame] highlightColor:[SSMacros colorHighlightedForVoteType:SSVoteTypeLame] titleLabel:@"SO lame!" withFontSize:20];
    self.soLameButton.titleLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:self.soLameButton.titleLabel.font.pointSize];
    [self.soLameButton addTarget:self
                         action:@selector(soLameButtonWasPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.soLameButton];
    
    self.tryAgain = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(0.5 * self.frame.size.width, 0.5 * frame.size.height, 0.5 * self.frame.size.width, 0.5 * self.frame.size.height) withBackgroundColor:[SSMacros colorNormalForVoteType:SSVoteTypeTryAgain] highlightColor:[SSMacros colorHighlightedForVoteType:SSVoteTypeTryAgain] titleLabel:@"SO weird!" withFontSize:20];
    self.tryAgain.titleLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:self.tryAgain.titleLabel.font.pointSize];
    [self.tryAgain addTarget:self
                         action:@selector(tryAgainButtonWasPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.tryAgain];
    
    
    [self disableButtons];
    
    return self;

}


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
    
    self.soFunnyButton.selected = NO;
    self.soHotButton.selected = NO;
    self.soLameButton.selected = NO;
    self.tryAgain.selected = NO;
    
}

-(void)enableButtons {
    self.soFunnyButton.enabled = YES;
    self.soHotButton.enabled = YES;
    self.soLameButton.enabled = YES;
    self.tryAgain.enabled = YES;
    
    self.soFunnyButton.selected = NO;
    self.soHotButton.selected = NO;
    self.soLameButton.selected = NO;
    self.tryAgain.selected = NO;
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
