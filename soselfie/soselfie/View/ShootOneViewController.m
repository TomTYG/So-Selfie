//
//  ShootOneViewController.m
//  SoSelfie
//
//  Created by TYG on 28/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "ShootOneViewController.h"

@interface ShootOneViewController ()

@end

@implementation ShootOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tabBarView = [[TabBarView alloc] init];
    //self.tabBarView.headerLabel.frame = CGRectMake(50, 10, 140, 60);
    self.tabBarView.headerLabel.text = @"shoot";
    self.tabBarView.voteButton.hidden = NO;
    [self.view addSubview:self.tabBarView];
    [self.view bringSubviewToFront:self.tabBarView];
    
    
    UIImageView *selfieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 320)];
    selfieImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selfieImageView];
    
    //setting up the bottom view
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 380, 320,184)];
    bottomView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
    [self.view addSubview:bottomView];
    
    UIView *topPinkBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)];
    topPinkBar.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    [bottomView addSubview:topPinkBar];
    
    self.shootYourSelfieBottomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.shootYourSelfieBottomButton setTitle:@"Shoot your selfie!" forState:UIControlStateNormal];
    self.shootYourSelfieBottomButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:23];
    [self.shootYourSelfieBottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shootYourSelfieBottomButton.frame = CGRectMake(0, 134, 320, 50);
    self.shootYourSelfieBottomButton.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    [bottomView addSubview:self.shootYourSelfieBottomButton];
    
    [self.shootYourSelfieBottomButton addTarget:self action:@selector(shootButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.pressShootButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pressShootButton setImage:[UIImage imageNamed:@"iphone5_shootbutton"] forState:UIControlStateNormal];
    [self.pressShootButton setImage:[UIImage imageNamed:@"iphone5_shootbuttonHOVER"] forState:UIControlStateHighlighted];
    self.pressShootButton.frame = CGRectMake(103, 15, 114, 114);
    [bottomView addSubview:self.pressShootButton];
    
    [self.pressShootButton addTarget:self action:@selector(shootButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.keepOrTryAgainViewController = [[KeepItOrTryAgainViewController alloc] initWithNibName:nil bundle:nil];
    self.keepOrTryAgainViewController.view.backgroundColor = [UIColor clearColor];
    self.keepOrTryAgainViewController.view.frame = CGRectMake(0, 568, 320, 184);
    [self addChildViewController:self.keepOrTryAgainViewController];
    [self.view addSubview:self.keepOrTryAgainViewController.view];
    [self.view bringSubviewToFront:self.keepOrTryAgainViewController.view];
    
}

- (void) shootButtonWasPressed {
    
    [self.keepOrTryAgainViewController slideUp];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
