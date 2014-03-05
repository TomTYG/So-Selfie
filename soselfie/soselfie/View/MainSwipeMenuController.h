//
//  MainSwipeMenuController.h
//  SoSelfie
//
//  Created by TYG on 20/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeMenuButton.h"
#import "NMRangeSlider.h"
#import "SSMacros.h"
#import "GenericSoSelfieButtonWithOptionalSubtitle.h"

@interface MainSwipeMenuController : UIViewController

@property (strong, nonatomic) NMRangeSlider *ageSlider;
@property (strong ,nonatomic) UIButton *boysFilterButton;
@property (strong ,nonatomic) UIButton *girlsFilterButton;

@property (strong,nonatomic) SwipeMenuButton *voteButton;
@property (strong,nonatomic) SwipeMenuButton *topSelfies;
@property (strong,nonatomic) SwipeMenuButton *shootOne;
@property (strong,nonatomic) SwipeMenuButton *yourSelfiesButton;



@property BOOL boysButtonIsPressed;
@property BOOL girlsButtonIsPressed;

@end
