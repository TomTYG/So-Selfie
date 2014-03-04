//
//  RootPictureTakerView.h
//  soselfie
//
//  Created by Tom van Kruijsbergen on 28/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class RootPictureTakerView;

@protocol RootPictureTakerViewDelegate <NSObject>

@required
-(void)pictureTakenViewSuccessfullyTookPicture:(RootPictureTakerView*)pictureTakerView;

@end

@interface RootPictureTakerView : UIView <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (weak) id<RootPictureTakerViewDelegate>delegate;

@end
