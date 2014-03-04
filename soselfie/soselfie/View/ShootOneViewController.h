//
//  ShootOneViewController.h
//  SoSelfie
//
//  Created by TYG on 28/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"
#import "KeepItOrTryAgainViewController.h"

@interface ShootOneViewController : UIViewController

@property (strong, nonatomic) TabBarView *tabBarView;
@property (strong, nonatomic) UIButton *pressShootButton;
@property (strong, nonatomic) UIButton *shootYourSelfieBottomButton;
@property (strong, nonatomic) KeepItOrTryAgainViewController *keepOrTryAgainViewController;

@end
