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


@class MainSwipeMenuController;
@protocol MainSwipeMenuControllerDelegate <NSObject>

@required
-(void)mainSwipeMenuControllerEraseClicked:(MainSwipeMenuController*)swipecontroller;

@end

@interface MainSwipeMenuController : UIViewController<UIAlertViewDelegate>

@property (weak) id<MainSwipeMenuControllerDelegate>delegate;

@property (strong, nonatomic) NMRangeSlider *ageSlider;
@property (strong ,nonatomic) UIButton *boysFilterButton;
@property (strong ,nonatomic) UIButton *girlsFilterButton;

@property (strong,nonatomic) SwipeMenuButton *voteButton;
@property (strong,nonatomic) SwipeMenuButton *topSelfies;
@property (strong,nonatomic) SwipeMenuButton *shootOne;
@property (strong,nonatomic) SwipeMenuButton *yourSelfiesButton;

@property UILabel *personName;
@property UIImageView *fbprofilepictureview;



@property BOOL boysButtonIsPressed;
@property BOOL girlsButtonIsPressed;

-(void)userloggedin;
-(void)userloggedout;

@end
