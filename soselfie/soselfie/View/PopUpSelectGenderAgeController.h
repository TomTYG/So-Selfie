//
//  PopUpSelectGenderAgeController.h
//  soselfie
//
//  Created by TYG on 06/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMacros.h"
#import "RankingButtonWithSubtitle.h"
#import "NMRangeSlider.h"

@class PopUpSelectGenderAgeController;

@protocol PopUpSelectGenderAgeControllerDelegate <NSObject>

@required
-(void)popUpSelectGenderAgeControllerReadyToLogin:(PopUpSelectGenderAgeController*)genderagecontroller;

@end

@interface PopUpSelectGenderAgeController : UIViewController

@property (weak) id<PopUpSelectGenderAgeControllerDelegate>delegate;

-(void)start;

@end
