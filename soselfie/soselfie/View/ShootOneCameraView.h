//
//  ShootOneCameraView.h
//  soselfie
//
//  Created by Tom van Kruijsbergen on 04/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class ShootOneCameraView;

@protocol ShootOneCameraViewDelegate <NSObject>

@required
-(void)cameraView:(ShootOneCameraView*)cameraView hasPreparedImage:(UIImage*)image;

@end



@interface ShootOneCameraView : UIView<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (weak) id<ShootOneCameraViewDelegate>delegate;

//this returns YES if your request was correctly processed and the object is about to take a picture, and NO if it is already taking a picture.
-(BOOL)takePicture;
-(void)removePicture;

@end
