//
//  ShootOneViewController.m
//  SoSelfie
//
//  Created by TYG on 28/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "ShootOneViewController.h"
#import "SSAPI.h"
#import "SSLoadingView.h"


@interface ShootOneViewController (){
    
    UIImage *pressShootButtonImage;
    UIImage *pressShootButtonImageHover;
    UIImage *currentPicture;
    SSLoadingView *loadingView;
    UIView *blockingview;
}
@property ShootOneCameraView *cameraView;

@end

@implementation ShootOneViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tabBarView = [[TabBarView alloc] init];
    self.tabBarView.headerLabel.text = @"Shoot a Selfie!";
    self.tabBarView.voteButton.hidden = NO;
    [self.view addSubview:self.tabBarView];
    
    float height = self.tabBarView.frame.origin.y + self.tabBarView.frame.size.height;
    
    UIImageView *selfieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, height, self.view.frame.size.width, 320)];
    selfieImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selfieImageView];

    self.cameraView = [[ShootOneCameraView alloc] initWithFrame:selfieImageView.frame];
    self.cameraView.delegate = self;
    [self.view addSubview:self.cameraView];
    
    
    
     if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
         
         pressShootButtonImage = [UIImage imageNamed:@"iphone5_shootbutton"];
         pressShootButtonImageHover = [UIImage imageNamed:@"iphone5_shootbuttonHOVER"];
         
     } else {
         pressShootButtonImage = [UIImage imageNamed:@"iphone4_shootbutton"];
         pressShootButtonImageHover = [UIImage imageNamed:@"iphone4_shootButton_HOVER"];
     }
    
    height = self.cameraView.frame.origin.y + self.cameraView.frame.size.height;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, height, self.view.frame.size.width, self.view.frame.size.height - height)];
    bottomView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
    [self.view addSubview:bottomView];
    
    UIView *topPinkBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 6)];
    topPinkBar.backgroundColor = [SSMacros colorNormalForVoteType:SSVoteTypeHot];//[UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    [bottomView addSubview:topPinkBar];
    
    
    
    height = topPinkBar.frame.origin.y + topPinkBar.frame.size.height;
    float imagewidth = pressShootButtonImage.size.width * 0.5 * pressShootButtonImage.scale;
    
    self.pressShootButton = [[UIButton alloc] initWithFrame:CGRectMake(0.5 * bottomView.frame.size.width - 0.5 * imagewidth, 6, imagewidth, imagewidth)];
    [self.pressShootButton setImage:pressShootButtonImage forState:UIControlStateNormal];
    [self.pressShootButton setImage:pressShootButtonImageHover forState:UIControlStateHighlighted];
    [self.pressShootButton addTarget:self action:@selector(shootButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.pressShootButton];
    
    
    //for now, the bottombutton is only visible on ihone 5, because there is actual room there. todo: make a proper design for this.
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
        
        height = self.pressShootButton.frame.origin.y + self.pressShootButton.frame.size.height;
        self.shootYourSelfieBottomButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(0, height, bottomView.frame.size.width, bottomView.frame.size.height - height) withBackgroundColor:[SSMacros colorNormalForVoteType:SSVoteTypeHot] highlightColor:[SSMacros colorHighlightedForVoteType:SSVoteTypeHot] titleLabel:@"Shoot it!" withFontSize:23];
        self.shootYourSelfieBottomButton.titleLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:23];
        [self.shootYourSelfieBottomButton addTarget:self action:@selector(shootButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:self.shootYourSelfieBottomButton];
        
    }
    
    
    self.keepOrTryAgainViewController = [[KeepItOrTryAgainViewController alloc] initWithNibName:nil bundle:nil];
    self.keepOrTryAgainViewController.view.backgroundColor = [UIColor clearColor];
    CGRect cr = bottomView.frame;
    height = topPinkBar.frame.origin.y + topPinkBar.frame.size.height;
    cr.origin.y += height;
    cr.size.height -= height;
    self.keepOrTryAgainViewController.view.frame = cr;
    [self.keepOrTryAgainViewController start];
    self.keepOrTryAgainViewController.delegate = self;
    [self.view addSubview:self.keepOrTryAgainViewController.view];
    
    blockingview = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:blockingview];
    blockingview.alpha = 0;
    
    //this view sets its own frame.
    loadingView = [[SSLoadingView alloc] initWithFrame:CGRectZero];
    loadingView.alpha = 0;
    cr = loadingView.frame;
    cr.origin.x = self.cameraView.frame.origin.x + 0.5 * self.cameraView.frame.size.width - 0.5 * cr.size.width;
    cr.origin.y = self.cameraView.frame.origin.y + 0.5 * self.cameraView.frame.size.height - 0.5 * cr.size.height;
    loadingView.frame = cr;
    [self.view addSubview:loadingView];
    
    [self.tabBarView.superview bringSubviewToFront:self.tabBarView];
}

- (void)shootButtonWasPressed {
    
    [self.cameraView takePicture];
    [self.keepOrTryAgainViewController slideUp];
    
}

-(void)cameraView:(ShootOneCameraView *)cameraView hasPreparedImage:(UIImage *)image {
    currentPicture = image;
}

-(void)keepItOrTryAgainViewControllerClickedNo:(KeepItOrTryAgainViewController *)viewcontroller {
    [self.cameraView removePicture];
}
-(void)keepItOrTryAgainViewControllerClickedYes:(KeepItOrTryAgainViewController *)viewcontroller {
    
    NSLog(@"uploading image %@", currentPicture);
    
    blockingview.alpha = 1;
    loadingView.alpha = 1;
    
    if (currentPicture == nil) return;
    
    [SSAPI uploadSelfieWith768x768Image:currentPicture onComplete:^(NSString *newSelfieID, NSString *newSelfieURL, NSString *newSelfieThumbURL, NSError *error) {
        
        currentPicture = nil;
        
        blockingview.alpha = 0;
        loadingView.alpha = 0;
        
        [self.cameraView removePicture];
        [self.keepOrTryAgainViewController slideDownInstant:NO];
        
        
        if (error != nil) {
            NSLog(@"image upload error %@", error);
            
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Oops, upload failed" message:@"Try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [v show];
            return;
        }
        
        [self.delegate shootOneViewControllerCameraSuccesfull:self];
        
    }];
}

@end
