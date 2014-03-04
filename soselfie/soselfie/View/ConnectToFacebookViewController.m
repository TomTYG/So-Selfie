//
//  ConnectToFacebookViewController.m
//  SoSelfie
//
//  Created by TYG on 03/03/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "ConnectToFacebookViewController.h"

@interface ConnectToFacebookViewController ()

@end

@implementation ConnectToFacebookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
        
        UIButton *connectToFacebokButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        connectToFacebokButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:25];
        [connectToFacebokButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        connectToFacebokButton.backgroundColor = [UIColor colorWithRed:87/255.0 green:117/255.0 blue:174/255.0 alpha:1.0];
        [connectToFacebokButton setTitle:@"Connect with Facebook" forState:UIControlStateNormal];
        connectToFacebokButton.frame = CGRectMake(0, 457, 320, 111);
        [self.view addSubview:connectToFacebokButton];
        
        UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(83, 201, 154, 167)];
        logoImageView.image = [UIImage imageNamed:@"logo"];
        [self.view addSubview:logoImageView];
        
        UILabel *weNeedYouLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 400, 320, 21)];
        weNeedYouLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:20];
        weNeedYouLabel.textColor = [UIColor colorWithRed:88/255.0 green:89/255.0 blue:91/255.0 alpha:1.0];
        weNeedYouLabel.text = @"We need you to Sign Up";
        weNeedYouLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:weNeedYouLabel];
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
