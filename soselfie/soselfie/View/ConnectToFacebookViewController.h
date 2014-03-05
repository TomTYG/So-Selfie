//
//  ConnectToFacebookViewController.h
//  SoSelfie
//
//  Created by TYG on 03/03/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingButtonWithSubtitle.h"
#import "SSMacros.h"

@class ConnectToFacebookViewController;

@protocol ConnectoToFacebookViewControllerDelegate <NSObject>

@required
-(void)connectToFacebookControllerLoginSuccessful:(ConnectToFacebookViewController*)viewcontroller wasUserInitiated:(BOOL)userInitiated;

@end

@interface ConnectToFacebookViewController : UIViewController

@property (weak) id<ConnectoToFacebookViewControllerDelegate>delegate;

@end
