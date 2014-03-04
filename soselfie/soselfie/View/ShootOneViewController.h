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
#import "SSMacros.h"
#import "ShootOneCameraView.h"


@class ShootOneViewController;
@protocol ShootOneViewControllerDelegate <NSObject>

@required
-(void)shootOneViewControllerCameraSuccesfull:(ShootOneViewController*)viewcontroller;

@end

@interface ShootOneViewController : UIViewController<ShootOneCameraViewDelegate, KeepItOrTryAgainViewControllerDelegate>


@property (weak) id<ShootOneViewControllerDelegate>delegate;

@property (strong, nonatomic) TabBarView *tabBarView;
@property (strong, nonatomic) UIButton *pressShootButton;
@property (strong, nonatomic) UIButton *shootYourSelfieBottomButton;
@property (strong, nonatomic) KeepItOrTryAgainViewController *keepOrTryAgainViewController;

@end
