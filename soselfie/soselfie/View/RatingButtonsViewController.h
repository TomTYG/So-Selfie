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

@interface RatingButtonsViewController : UIViewController

@property (strong, nonatomic) UIButton *soFunnyButton;
@property (strong, nonatomic) UIButton *soHotButton;
@property (strong, nonatomic) UIButton *soLameButton;
@property (strong, nonatomic) UIButton *tryAgain;

-(void)slideUp;
-(void)slideDownWithDuration:(double)duration;

@end
