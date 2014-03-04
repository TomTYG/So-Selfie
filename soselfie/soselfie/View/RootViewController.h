//
//  RootViewController.h
//  soselfie
//
//  Created by Tom van Kruijsbergen on 18/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootVoteSelfieView.h"
#import "RootPictureTakerView.h"

@interface RootViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, RootVoteSelfieViewDelegate, RootPictureTakerViewDelegate
>

@end
