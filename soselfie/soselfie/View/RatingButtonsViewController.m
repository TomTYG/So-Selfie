//
//  RatingButtonsViewController.m
//  SoSelfie
//
//  Created by TYG on 18/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "RatingButtonsViewController.h"

@interface RatingButtonsViewController ()

@end

@implementation RatingButtonsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor clearColor];
    //sofunnybutton
    self.soFunnyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.soFunnyButton setTitle:@"SO funny!" forState:UIControlStateNormal];
    self.soFunnyButton.titleLabel.font =  [UIFont fontWithName:@"MyriadPro-Bold" size:20];
    [self.soFunnyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.soFunnyButton.frame = CGRectMake(0, 0, 160, 95);
    [self.soFunnyButton addTarget:self
               action:@selector(soFunnyButtonWasPressed)
     forControlEvents:UIControlEventTouchUpInside];
    self.soFunnyButton.backgroundColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
    [self.view addSubview:self.soFunnyButton];
    
    //sohotbutton
    self.soHotButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.soHotButton setTitle:@"SO hot!" forState:UIControlStateNormal];
    self.soHotButton.titleLabel.font =  [UIFont fontWithName:@"MyriadPro-Bold" size:20];
    [self.soHotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.soHotButton.frame = CGRectMake(160, 0, 160, 95);
    [self.soHotButton addTarget:self
                           action:@selector(soHotButtonWasPressed)
                 forControlEvents:UIControlEventTouchUpInside];
    self.soHotButton.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    [self.view addSubview:self.soHotButton];
    
    //solamebutton
    self.soLameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.soLameButton setTitle:@"SO lame!" forState:UIControlStateNormal];
    self.soLameButton.titleLabel.font =  [UIFont fontWithName:@"MyriadPro-Bold" size:20];
    [self.soLameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.soLameButton.frame = CGRectMake(0, 95, 160, 95);
    [self.soLameButton addTarget:self
                           action:@selector(soLameButtonWasPressed)
                 forControlEvents:UIControlEventTouchUpInside];
    self.soLameButton.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
    [self.view addSubview:self.soLameButton];
    
    //tryAgain
    self.tryAgain = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.tryAgain setTitle:@"SO wierd!" forState:UIControlStateNormal];
    self.tryAgain.titleLabel.font =  [UIFont fontWithName:@"MyriadPro-Bold" size:20];
    [self.tryAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.tryAgain.frame = CGRectMake(160, 95, 160, 95);
    [self.tryAgain addTarget:self
                           action:@selector(tryAgainButtonWasPressed)
                 forControlEvents:UIControlEventTouchUpInside];
    self.tryAgain.backgroundColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
    [self.view addSubview:self.tryAgain];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)soFunnyButtonWasPressed {
    NSLog (@"SOOO funny!");
    [self slideDownWithDuration:0.4];
}

-(void)soHotButtonWasPressed {
    NSLog (@"SOOO hot!");
    [self slideDownWithDuration:0.4];
}

-(void)soLameButtonWasPressed {
    NSLog (@"SOOOO lame!");
    [self slideDownWithDuration:0.4];
}

-(void)tryAgainButtonWasPressed {
    NSLog (@"Try again!");
    [self slideDownWithDuration:0.4];
}

-(void)slideUp{
    
    CGRect newButtonsControllerFrame = self.view.frame;
    newButtonsControllerFrame.origin.y = 380;
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.view.frame = newButtonsControllerFrame;
                     }
                     completion:nil];
}




-(void)slideDownWithDuration:(double)duration{

    
    CGRect newButtonsControllerFrame = self.view.frame;
    newButtonsControllerFrame.origin.y = 568;
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = newButtonsControllerFrame;
                     }
                     completion:nil];

}
    

@end
