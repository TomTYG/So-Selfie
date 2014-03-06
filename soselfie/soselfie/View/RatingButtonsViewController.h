//
//  RatingButtonsViewController.h
//  SoSelfie
//
//  Created by TYG on 18/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingButtonWithSubtitle.h"
#import "SSMacros.h"
#import "SSAPI.h"

@class RatingButtonsViewController;

@protocol RatingButtonsViewControllerDelegate <NSObject>

@required
-(void)ratingButtonsViewController:(RatingButtonsViewController*)viewcontroller pressedVote:(SSVoteType)voteType;

@end

@interface RatingButtonsViewController : UIViewController

@property (weak) id<RatingButtonsViewControllerDelegate>delegate;

@property (strong, nonatomic) UIButton *soFunnyButton;
@property (strong, nonatomic) UIButton *soHotButton;
@property (strong, nonatomic) UIButton *soLameButton;
@property (strong, nonatomic) UIButton *tryAgain;

-(void)slideUp;
-(void)slideDownWithDuration:(double)duration;

@end
