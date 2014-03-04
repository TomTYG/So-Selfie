//
//  VoteButtonVIew.h
//  SoSelfie
//
//  Created by TYG on 27/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingButtonWithSubtitle.h"
#import "SSAPI.h"

@class VoteButtonView;
@protocol VoteButtonViewDelegate <NSObject>

@required
-(void)voteButtonView:(VoteButtonView*)voteButtonView pressedButton:(UIButton*)button vote:(SSVoteType)vote;

@end

@interface VoteButtonView : UIView

@property (strong, nonatomic) RankingButtonWithSubtitle *soFunnyButton;
@property (strong, nonatomic) RankingButtonWithSubtitle *soHotButton;
@property (strong, nonatomic) RankingButtonWithSubtitle *soLameButton;
@property (strong, nonatomic) RankingButtonWithSubtitle *tryAgain;

@property (weak) id<VoteButtonViewDelegate>delegate;

-(void)startWithVotesDictionary:(NSDictionary*)dictionary;
-(void)prepareForReuse;
@end
