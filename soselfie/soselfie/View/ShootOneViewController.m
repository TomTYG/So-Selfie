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
    
    
    UIImageView *selfieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 320)];
    selfieImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selfieImageView];

    self.cameraView = [[ShootOneCameraView alloc] initWithFrame:selfieImageView.frame];
    self.cameraView.delegate = self;
    [self.view addSubview:self.cameraView];
    
    //setting up the bottom view
    float bottomViewHeight;
    float bottomButtonHeight;
    int imageSize;
    int buttonMarginY;
    int bottomViewYOrigin;
    
     if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
         bottomViewHeight = 190;
         bottomButtonHeight = 56;
         imageSize = 114;
         buttonMarginY = 15;
         pressShootButtonImage = [UIImage imageNamed:@"iphone5_shootbutton"];
         pressShootButtonImageHover = [UIImage imageNamed:@"iphone5_shootbuttonHOVER"];
         bottomViewYOrigin = self.view.frame.size.height - bottomViewHeight; //WHAT IS THIS 6?????
     }
    
     else {
         bottomViewHeight = 120;
         bottomButtonHeight = 27;
         imageSize = 82;
         buttonMarginY = 8;
         pressShootButtonImage = [UIImage imageNamed:@"iphone4_shootbutton"];
         pressShootButtonImageHover = [UIImage imageNamed:@"iphone4_shootButton_HOVER"];
         //bottomViewYOrigin = [[UIScreen mainScreen] bounds].size.height - bottomViewHeight - [UIApplication sharedApplication].statusBarFrame.size.height;
         bottomViewYOrigin = self.view.frame.size.height - bottomViewHeight;
         
     }
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomViewYOrigin, 320,bottomViewHeight)];
    bottomView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
    [self.view addSubview:bottomView];
    
    UIView *topPinkBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)];
    topPinkBar.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    [bottomView addSubview:topPinkBar];
    
    self.shootYourSelfieBottomButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(0, bottomView.frame.size.height - bottomButtonHeight, bottomView.frame.size.width, bottomButtonHeight) withBackgroundColor:[UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1] highlightColor:[UIColor colorWithRed:(252/255.0) green:(96/255.0) blue:(152/255.0) alpha:1] titleLabel:@"Shoot it!" withFontSize:23];
    //self.shootYourSelfieBottomButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(0, bottomView.frame.size.height - bottomButtonHeight, bottomView.frame.size.width, bottomButtonHeight) withBackgroundColor:[UIColor blackColor] highlightColor:[UIColor darkGrayColor] titleLabel:@"Shoot it!" withFontSize:23];
    self.shootYourSelfieBottomButton.titleLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:23];
    [self.shootYourSelfieBottomButton addTarget:self action:@selector(shootButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.shootYourSelfieBottomButton];
    
    
    
    self.pressShootButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pressShootButton setImage:pressShootButtonImage forState:UIControlStateNormal];
    [self.pressShootButton setImage:pressShootButtonImageHover forState:UIControlStateHighlighted];
    self.pressShootButton.frame = CGRectMake((self.view.frame.size.width - imageSize)/2, buttonMarginY, imageSize, imageSize);
    [bottomView addSubview:self.pressShootButton];
    
     
    [self.pressShootButton addTarget:self action:@selector(shootButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.keepOrTryAgainViewController = [[KeepItOrTryAgainViewController alloc] initWithNibName:nil bundle:nil];
    self.keepOrTryAgainViewController.view.backgroundColor = [UIColor clearColor];
    self.keepOrTryAgainViewController.view.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, 320, bottomViewHeight);
    self.keepOrTryAgainViewController.delegate = self;
    [self.view addSubview:self.keepOrTryAgainViewController.view];
    
    blockingview = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:blockingview];
    blockingview.alpha = 0;
    
    loadingView = [[SSLoadingView alloc] initWithFrame:CGRectZero];
    loadingView.alpha = 0;
    CGRect cr = loadingView.frame;
    cr.origin.x = self.cameraView.frame.origin.x + 0.5 * self.cameraView.frame.size.width - 0.5 * cr.size.width;
    cr.origin.y = self.cameraView.frame.origin.y + 0.5 * self.cameraView.frame.size.height - 0.5 * cr.size.height;
    loadingView.frame = cr;
    [self.view addSubview:loadingView];
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
        [self.keepOrTryAgainViewController slideDown];
        
        
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
