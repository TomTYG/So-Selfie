//
//  ConnectToFacebookViewController.m
//  SoSelfie
//
//  Created by TYG on 03/03/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "ConnectToFacebookViewController.h"
#import "SSAPI.h"
@interface ConnectToFacebookViewController () {
    RankingButtonWithSubtitle *connectToFacebookButton;
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
    
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    
    connectToFacebookButton = [[RankingButtonWithSubtitle alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height - buttonHeight, 320, buttonHeight)];
    connectToFacebookButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:25];
    connectToFacebookButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [connectToFacebookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    connectToFacebookButton.backgroundColor = [UIColor colorWithRed:87/255.0 green:117/255.0 blue:174/255.0 alpha:1.0];
    [connectToFacebookButton setTitle:@"Connect with Facebook" forState:UIControlStateNormal];
    [connectToFacebookButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, bottomInset, 0)];
    [connectToFacebookButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [connectToFacebookButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(103/255.0) green:(140/255.0) blue:(198/255.0) alpha:1]] forState:UIControlStateHighlighted];
    [self.view addSubview:connectToFacebookButton];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(83, logoYOrigin, 154, 167)];
    logoImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logoImageView];
    
    UILabel *weNeedYouLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, labeYOrigin, 320, 21)];
    weNeedYouLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
    weNeedYouLabel.backgroundColor = [UIColor clearColor];
    weNeedYouLabel.textColor = [UIColor colorWithRed:88/255.0 green:89/255.0 blue:91/255.0 alpha:1.0];
    weNeedYouLabel.text = @"We need you to Sign Up";
    weNeedYouLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:weNeedYouLabel];
    
    if ([SSAPI canLoginToFacebookWithoutPromptingUser] == true) {
        [self loginUserInitiated:false];
    }
    
    return self;
}

-(void)loginButtonClicked:(id)sender {
    [self loginUserInitiated:true];
}

-(void)loginUserInitiated:(BOOL)userInitiated {
    connectToFacebookButton.enabled = NO;
    
    [SSAPI logInToFacebookOnComplete:^(NSString *fbid, NSString *accessToken, BOOL couldRetrieveGender, BOOL couldRetrieveBirthday, NSError *error){
        NSLog(@"logged in %@", error);
        connectToFacebookButton.enabled = YES;
        
        if (error != nil) {
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Login error" message:@"Please try logging in again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            if (userInitiated == true) [v show];
            return;
        }
        
        //TODO: create popups that determine whether age and gender could be retrieved, and allow the user to set them.
        
        if(couldRetrieveBirthday == false || couldRetrieveGender == false){
            
        PopUpSelectGenderAgeController *popUpSelectGenderAgeController = [[PopUpSelectGenderAgeController alloc] init];
        [self.view addSubview:popUpSelectGenderAgeController.view];
        
        }
        
        [self.delegate connectToFacebookControllerLoginSuccessful:self wasUserInitiated:userInitiated];
        
    }];
}

@end
