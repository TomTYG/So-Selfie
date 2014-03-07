//
//  ConnectToFacebookViewController.m
//  SoSelfie
//
//  Created by TYG on 03/03/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "ConnectToFacebookViewController.h"
#import "SSAPI.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ConnectToFacebookViewController () {
    RankingButtonWithSubtitle *connectToFacebookButton;
    PopUpSelectGenderAgeController *popUpSelectGenderAgeController;
    
    UIImageView *splashScreenOverlay;
    
    UIView *subviewForMainItems;
}

@end

@implementation ConnectToFacebookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    int buttonHeight;
    int bottomInset;
    int logoYOrigin;
    int labeYOrigin;
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
        
        buttonHeight = 92;
        bottomInset = 0;
        logoYOrigin = 201;
        labeYOrigin = 400;
        
    }
    
    else {
        
        buttonHeight = 60;
        bottomInset = 15;
        logoYOrigin = 150;
        labeYOrigin = 64;
    }
    
    subviewForMainItems = [[UIView alloc] initWithFrame:self.view.frame];
    subviewForMainItems.backgroundColor = [UIColor clearColor];
    [self.view addSubview:subviewForMainItems];
    
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    
    connectToFacebookButton = [[RankingButtonWithSubtitle alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - buttonHeight, 320, buttonHeight)];
    connectToFacebookButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:25];
    connectToFacebookButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [connectToFacebookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    connectToFacebookButton.backgroundColor = [UIColor colorWithRed:87/255.0 green:117/255.0 blue:174/255.0 alpha:1.0];
    [connectToFacebookButton setTitle:@"Connect with Facebook" forState:UIControlStateNormal];
    [connectToFacebookButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, bottomInset, 0)];
    [connectToFacebookButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [connectToFacebookButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(103/255.0) green:(140/255.0) blue:(198/255.0) alpha:1]] forState:UIControlStateHighlighted];
    [subviewForMainItems addSubview:connectToFacebookButton];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(83, logoYOrigin, 154, 167)];
    logoImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logoImageView];
    
    UILabel *weNeedYouLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, labeYOrigin, 320, 21)];
    weNeedYouLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
    weNeedYouLabel.backgroundColor = [UIColor clearColor];
    weNeedYouLabel.textColor = [UIColor colorWithRed:88/255.0 green:89/255.0 blue:91/255.0 alpha:1.0];
    weNeedYouLabel.text = @"We need you to Sign Up";
    weNeedYouLabel.textAlignment = NSTextAlignmentCenter;
    [subviewForMainItems addSubview:weNeedYouLabel];
    
    
    if ([SSAPI canLoginToFacebookWithoutPromptingUser] == true) {
        double delayInSeconds = 0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self loginUserInitiated:false];
        });
        
    }
    
    return self;
}

-(void)loginButtonClicked:(id)sender {
    [self loginUserInitiated:true];
}

-(void)loginUserInitiated:(BOOL)userInitiated {
    connectToFacebookButton.enabled = NO;
    
    
    if (userInitiated == false) {
        splashScreenOverlay = [[UIImageView alloc] initWithFrame:self.view.bounds];
        splashScreenOverlay.backgroundColor = [UIColor clearColor];
        BOOL b = GET_DEVICE_TYPE == SSDeviceTypeiPhone5;
        UIImage *img = [UIImage imageNamed:b == true ? @"Default-568h" : @"Default" ];
        splashScreenOverlay.contentMode = UIViewContentModeScaleAspectFit;
        splashScreenOverlay.image = img;
        //todo: set the image to the splash screen image.
        //splashScreenOverlay.backgroundColor = [UIColor greenColor];
        [self.view addSubview:splashScreenOverlay];
    }
    
    NSLog(@"logging in");
    
    [SSAPI logInToFacebookOnComplete:^(NSString *fbid, NSString *accessToken, BOOL couldRetrieveGender, BOOL couldRetrieveBirthday, NSError *error){
        
        
        NSLog(@"logged in %@", error);
        connectToFacebookButton.enabled = YES;
        
        if (error != nil) {
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Login error" message:@"Please try logging in again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            if (userInitiated == true) [v show];
            if (userInitiated == false) {
                [splashScreenOverlay removeFromSuperview];
                splashScreenOverlay = nil;
                [self.delegate connectToFacebookControllerAutoLoginFailed:self];
            }
            return;
        }
        
        //couldRetrieveBirthday = false;
        
        
        
        if(couldRetrieveBirthday == false || couldRetrieveGender == false){
            
            //if the user did not initiate this login, then we don't want him to suddenly see this popup out of the blue. let him click the button again and find out.
            if (userInitiated == false) {
                [splashScreenOverlay removeFromSuperview];
                splashScreenOverlay = nil;
                [self.delegate connectToFacebookControllerAutoLoginFailed:self];
            }
            
            popUpSelectGenderAgeController = [[PopUpSelectGenderAgeController alloc] init];
            popUpSelectGenderAgeController.delegate = self;
            
            [subviewForMainItems addSubview:popUpSelectGenderAgeController.view];
            
            
        } else {
            
            [self sendInfoToServerUserInitiated:userInitiated];
            
            
        }
        
        
        
    }];
}

-(void)popUpSelectGenderAgeControllerReadyToLogin:(PopUpSelectGenderAgeController *)genderagecontroller {
    [self sendInfoToServerUserInitiated:true];
}

-(void)sendInfoToServerUserInitiated:(BOOL)userInitiated {
    
    [SSAPI sendProfileInfoToServerWithonComplete:^(BOOL success, NSError *possibleError){
        if (possibleError != nil) {
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Login error" message:@"Please try logging in again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            if (userInitiated == true) [v show];
            return;
        }
        
        
        //NSLog(@"popup view %@", splashScreenOverlay.view);
        if (splashScreenOverlay != nil) subviewForMainItems.alpha = 0;
        
        
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [popUpSelectGenderAgeController.view removeFromSuperview];
            popUpSelectGenderAgeController = nil;
            
            [splashScreenOverlay removeFromSuperview];
            splashScreenOverlay = nil;
        });
        
        
        [self.delegate connectToFacebookControllerLoginSuccessful:self wasUserInitiated:userInitiated];
    }];
}

@end
