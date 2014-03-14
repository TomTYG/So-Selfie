//
//  VoteButtonVIew.h
//  SoSelfie
//
//  Created by TYG on 27/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingButtonWithSubtitle.h"
#import "GenericSoSelfieButtonWithOptionalSubtitle.h"
#import "SSAPI.h"

@class VoteButtonView;
@protocol VoteButtonViewDelegate <NSObject>

@required
-(void)voteButtonView:(VoteButtonView*)voteButtonView pressedButton:(UIButton*)button vote:(SSVoteType)vote;

@end

@interface VoteButtonView : UIView

@property GenericSoSelfieButtonWithOptionalSubtitle *soFunnyButton;
@property GenericSoSelfieButtonWithOptionalSubtitle *soHotButton;
@property GenericSoSelfieButtonWithOptionalSubtitle *soLameButton;
@property GenericSoSelfieButtonWithOptionalSubtitle *tryAgain;

@property (weak) id<VoteButtonViewDelegate>delegate;

-(void)startWithVotesDictionary:(NSDictionary*)dictionary;
-(void)prepareForReuse;

-(void)disableButtons;
-(void)enableButtons;
@end
