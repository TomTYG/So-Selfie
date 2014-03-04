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
}

@end

@implementation KeepItOrTryAgainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        wowKeepItButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [wowKeepItButton setTitle:@"Wow! Let's keep it" forState:UIControlStateNormal];
        wowKeepItButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:28];
        wowKeepItButton.backgroundColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
        [wowKeepItButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        wowKeepItButton.frame = CGRectMake(0, 0, 320, 92);
        [wowKeepItButton addTarget:self action:@selector(takePhotoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:wowKeepItButton];
        
        
        tryAgainButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [tryAgainButton setTitle:@"Hmm... try again" forState:UIControlStateNormal];
        tryAgainButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:28];
        tryAgainButton.backgroundColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
        [tryAgainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tryAgainButton.frame = CGRectMake(0, 92, 320, 92);
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
    newFrame.origin.y = 384;
    
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
