//
//  KeepItOrTryAgainViewController.h
//  SoSelfie
//
//  Created by TYG on 03/03/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMacros.h"

@class KeepItOrTryAgainViewController;

@protocol KeepItOrTryAgainViewControllerDelegate <NSObject>

@required
-(void)keepItOrTryAgainViewControllerClickedYes:(KeepItOrTryAgainViewController*)viewcontroller;
-(void)keepItOrTryAgainViewControllerClickedNo:(KeepItOrTryAgainViewController*)viewcontroller;

@end

@interface KeepItOrTryAgainViewController : UIViewController

@property (weak) id<KeepItOrTryAgainViewControllerDelegate>delegate;

-(void)slideUp;
-(void)slideDownInstant:(BOOL)instant;
-(void)start;

@end
