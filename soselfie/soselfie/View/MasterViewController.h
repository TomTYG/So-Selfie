//
//  MasterViewController.h
//  SoSelfie
//
//  Created by TYG on 21/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "MainSwipeMenuController.h"
#import "VoteViewController.h"
#import "YourSelfiesController.h"
#import "ShootOneViewController.h"
#import "ConnectToFacebookViewController.h"

@interface MasterViewController : UIViewController 

@property (strong, nonatomic) ViewController *topChartViewController;
@property (strong, nonatomic) MainSwipeMenuController *mainSwipeViewController;
@property (strong , nonatomic) UIView *genericCentralVIew;
@property (strong, nonatomic) VoteViewController *voteViewController;
@property (strong, nonatomic) TabBarView *tabBarView;
@property (strong, nonatomic) DropDownMenu *dropDownMenu;
@property (strong, nonatomic) YourSelfiesController *yourSelfiesViewController;
@property (strong, nonatomic) ShootOneViewController *shootOneViewController;
@property (strong, nonatomic) ConnectToFacebookViewController *connectToFacebookContoller;
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (strong, nonatomic) UIPanGestureRecognizer *panRecognizer; 
@property BOOL swipeMenuIsVisible;

@end
