//
//  KeepItOrTryAgainViewController.m
//  SoSelfie
//
//  Created by TYG on 03/03/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "KeepItOrTryAgainViewController.h"

@interface KeepItOrTryAgainViewController () {
    UIButton *wowKeepItButton;
    UIButton *tryAgainButton;
    int newFrameY;
}

@end

@implementation KeepItOrTryAgainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        int buttonHieght;
        int fontSize;
        
         if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
             
             buttonHieght = 92;
             fontSize = 28;
             newFrameY = [[UIScreen mainScreen] bounds].size.height - buttonHieght*2;
             
             
         }
         else {
             
             buttonHieght = 60;
             fontSize = 24;
             newFrameY = [[UIScreen mainScreen] bounds].size.height - buttonHieght*2 - [UIApplication sharedApplication].statusBarFrame.size.height ;
             
         }
        
        wowKeepItButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wowKeepItButton setTitle:@"Wow! Let's keep it" forState:UIControlStateNormal];
        wowKeepItButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:fontSize];
        wowKeepItButton.backgroundColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
        [wowKeepItButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        wowKeepItButton.frame = CGRectMake(0, 0, 320, buttonHieght);
        [wowKeepItButton addTarget:self action:@selector(takePhotoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:wowKeepItButton];
        
        
        tryAgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tryAgainButton setTitle:@"Hmm... try again" forState:UIControlStateNormal];
        tryAgainButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:fontSize];
        tryAgainButton.backgroundColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
        [tryAgainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tryAgainButton.frame = CGRectMake(0, buttonHieght, 320, buttonHieght);
        [self.view addSubview:tryAgainButton];
        
        [tryAgainButton addTarget:self action:@selector(tryAgainButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)takePhotoButtonClicked:(id)sender {
    tryAgainButton.enabled = NO;
    wowKeepItButton.enabled = NO;
    [self.delegate keepItOrTryAgainViewControllerClickedYes:self];
}
-(void)tryAgainButtonClicked:(id)sender {
    [self slideDown];
    [self.delegate keepItOrTryAgainViewControllerClickedNo:self];
}

-(void) slideUp {
    CGRect newFrame = self.view.frame;
    newFrame.origin.y =newFrameY ;
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.view.frame = newFrame;
                     }
                     completion:nil];
}

- (void) slideDown {
    tryAgainButton.enabled = YES;
    wowKeepItButton.enabled = YES;
    
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = 584;//self.view.frame.size.height;
    
    
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = newFrame;
                     }
                     completion:nil];
    
}


@end
