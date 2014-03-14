//
//  KeepItOrTryAgainViewController.m
//  SoSelfie
//
//  Created by TYG on 03/03/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "KeepItOrTryAgainViewController.h"
#import "GenericSoSelfieButtonWithOptionalSubtitle.h"

@interface KeepItOrTryAgainViewController () {
    GenericSoSelfieButtonWithOptionalSubtitle *wowKeepItButton;
    GenericSoSelfieButtonWithOptionalSubtitle *tryAgainButton;
    
    float startframepos;
}

@end

@implementation KeepItOrTryAgainViewController


-(void)start {
    float fontsize = 24;
    
    wowKeepItButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5 * self.view.frame.size.height) withBackgroundColor:[SSMacros colorNormalForVoteType:SSVoteTypeFunny] highlightColor:[SSMacros colorHighlightedForVoteType:SSVoteTypeFunny] titleLabel:@"Wow! Let's keep it" withFontSize:fontsize];
    [wowKeepItButton setTitle:@"Wow! Let's keep it" forState:UIControlStateNormal];
    wowKeepItButton.titleLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    
    [wowKeepItButton addTarget:self action:@selector(takePhotoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wowKeepItButton];
    
    
    tryAgainButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(0, 0.5 * self.view.frame.size.height, self.view.frame.size.width, 0.5 * self.view.frame.size.height) withBackgroundColor:[SSMacros colorNormalForVoteType:SSVoteTypeTryAgain] highlightColor:[SSMacros colorHighlightedForVoteType:SSVoteTypeTryAgain] titleLabel:@"Hmm... try again" withFontSize:fontsize];
    tryAgainButton.titleLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    
    [self.view addSubview:tryAgainButton];
    
    startframepos = self.view.frame.origin.y;
    
    [self slideDownInstant:YES];
    
    [tryAgainButton addTarget:self action:@selector(tryAgainButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)takePhotoButtonClicked:(id)sender {
    //tryAgainButton.enabled = NO;
    //wowKeepItButton.enabled = NO;
    [self.delegate keepItOrTryAgainViewControllerClickedYes:self];
}
-(void)tryAgainButtonClicked:(id)sender {
    [self slideDownInstant:NO];
    [self.delegate keepItOrTryAgainViewControllerClickedNo:self];
}

-(void) slideUp {
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = startframepos;
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:0
                     animations:^{
                         self.view.frame = newFrame;
                     }
                     completion:nil];
}

- (void) slideDownInstant:(BOOL)instant {
    //tryAgainButton.enabled = YES;
    //wowKeepItButton.enabled = YES;
    
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = startframepos + self.view.frame.size.height;
    
    NSTimeInterval duration = instant ? 0 : 0.4;
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:0
                     animations:^{
                         self.view.frame = newFrame;
                     }
                     completion:nil];
    
}


@end
