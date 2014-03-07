//
//  ShootOneCameraView.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 04/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "ShootOneCameraView.h"
#import "SSAPI.h"
#import "UIImageExtras.h"

@interface ShootOneCameraView() {
    UIView *cameraView;
    UIImageView *cameraImageView;
    //UIButton *takepicturebutton;
}

@property (strong) AVCaptureDevice *camera;
@property (strong) AVCaptureDeviceInput *camerainput;
@property (strong) AVCaptureVideoDataOutput *cameraoutput;
@property (strong) AVCaptureConnection *cameraconnection;
@property (strong) AVCaptureSession *session;
@property (strong) CATransition *shutterAnimation;
@property AVCaptureVideoPreviewLayer *videolayer;

@property BOOL takingphoto;

@end

@implementation ShootOneCameraView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.takingphoto = NO;
    
    cameraView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    cameraView.backgroundColor = [UIColor lightGrayColor];
    cameraView.layer.masksToBounds = YES;
    [self addSubview:cameraView];
    
    cameraImageView = [[UIImageView alloc] initWithFrame:cameraView.frame];
    cameraImageView.backgroundColor = [UIColor clearColor];
    cameraImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:cameraImageView];
    
    /*
    float MARGIN = 6;
    float height = cameraView.frame.origin.y + cameraView.frame.size.height + MARGIN;
    
    takepicturebutton = [[UIButton alloc] initWithFrame:CGRectMake(0, height, self.frame.size.width, 40)];
    [takepicturebutton setTitle:@"Take and upload picture" forState:UIControlStateNormal];
    [takepicturebutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [takepicturebutton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [takepicturebutton addTarget:self action:@selector(takepicturebuttonpressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:takepicturebutton];
    */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
        [self setSession:[[AVCaptureSession alloc] init]];
        
        
        NSArray *a = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        
        AVCaptureDevice *d;
        
        for (int i = 0; i < [a count]; i++) {
            d = [a objectAtIndex:i];
            if ([d position] == AVCaptureDevicePositionFront) break;
        }
        
        [self setCamera:d];
        
        NSError *error = nil;
        [d lockForConfiguration:&error];
        
        NSError *error2 = nil;
        //[d setFlashMode:AVCaptureFlashModeOn];
        //NSLog(@"setting up camera flash supported %@ %@", [NSNumber numberWithBool:[d isFlashAvailable]], [NSNumber numberWithInt:[d flashMode]]);
        
        
        [self setCamerainput:[AVCaptureDeviceInput deviceInputWithDevice:d error:&error2]];
        [d unlockForConfiguration];
        
        if (error2 != nil) NSLog(@"error with device input %@", [error2 description]);
        NSLog(@"camera input %@", [self camerainput]);
        
        
        [self setCameraoutput:[[AVCaptureVideoDataOutput alloc] init]];
        dispatch_queue_t videoCaptureQueue = dispatch_queue_create("Video Capture Queue", DISPATCH_QUEUE_SERIAL);
        [[self cameraoutput] setSampleBufferDelegate:self queue:videoCaptureQueue];
        //dispatch_release(videoCaptureQueue);
        
        [[self cameraoutput] setVideoSettings:[NSDictionary dictionaryWithObject: [NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
        
        dispatch_sync(dispatch_get_main_queue(), ^() {
            
            [self setVideolayer:[AVCaptureVideoPreviewLayer layerWithSession:[self session]]];
            [[self videolayer] setFrame:[cameraView bounds]];
            [[self videolayer] setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            
            [cameraView.layer addSublayer:[self videolayer]];
            
            self.shutterAnimation = [CATransition animation];
            [self.shutterAnimation setDelegate:self];
            [self.shutterAnimation setDuration:0.6];
            
            self.shutterAnimation.timingFunction = UIViewAnimationCurveEaseInOut;
            [self.shutterAnimation setType:@"cameraIris"];
            [self.shutterAnimation setValue:@"cameraIris" forKey:@"cameraIris"];
            CALayer *cameraShutter = [[CALayer alloc]init];
            cameraShutter.masksToBounds = YES;
            [cameraShutter setBounds:cameraView.bounds];
            [cameraView.layer addSublayer:cameraShutter];
            
            
            
            
            
            [[self session] beginConfiguration];
            
            [[self session] addInput:[self camerainput]];
            [[self session] addOutput:[self cameraoutput]];
            
            [[self session] setSessionPreset:AVCaptureSessionPresetHigh];
            
            
            [[self session] commitConfiguration];
            
            
            [self.session startRunning];
            /*
             [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cameranotification:) name:AVCaptureSessionDidStartRunningNotification object:[self session]];
             [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cameranotification:) name:AVCaptureSessionRuntimeErrorNotification object:[self session]];
             [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cameranotification:) name:AVCaptureSessionDidStopRunningNotification object:[self session]];
             */
        });
        
        
    });
    
    
    
    return self;
}



-(BOOL)takePicture {
    if (self.takingphoto == true) return NO;
    
    self.videolayer.connection.enabled = false;
    [cameraView.layer addAnimation:self.shutterAnimation forKey:@"cameraIris"];
    
    self.takingphoto = true;
    return YES;
}



-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    if (self.takingphoto == false) return;
    
    CFAllocatorRef ca = CFAllocatorGetDefault();
    CMSampleBufferRef cs;
    CMSampleBufferCreateCopy(ca, sampleBuffer, &cs);
    
    CMSampleBufferSetDataReady(cs);
    
    UIImage *img = [self imageFromSampleBuffer:sampleBuffer];
    img = [img cropCenterAndScaleImageToSize:CGSizeMake(768, 768)];
    //NSLog(@"taking picture %@ %f %f", img, img.size.width, img.size.height);
    
    CFRelease(cs);
    
    [self performSelectorOnMainThread:@selector(pictureReceived:) withObject:img waitUntilDone:NO];
    
}

- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    
    
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    //NSLog(@"%zu %zu %zu", bytesPerRow, width, height);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    //CFRelease(context);
    //CFRelease(colorSpace);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    image = [self rotateImage:image byDegree:90];
    image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:(image.imageOrientation + 4) % 8];
    
    return (image);
    
}

-(UIImage *)rotateImage:(UIImage*)image byDegree:(CGFloat)degrees
{
    CGFloat radians = degrees * M_PI / 180;
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    //[rotatedViewBox release];
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    
    CGContextTranslateCTM(bitmap, rotatedSize.width, rotatedSize.height);
    
    CGContextRotateCTM(bitmap, radians);
    
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width, -image.size.height, image.size.width, image.size.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}






-(void)pictureReceived:(UIImage*)img { //this needs to be called on the main thread.
    self.takingphoto = false;
    
    //img = [UIImage imageWithCGImage:img.CGImage scale:img.scale orientation:(img.imageOrientation + 4) % 8];
    
    cameraImageView.image = img;
    
    
    
    [self.delegate cameraView:self hasPreparedImage:img];
    
    
    /*
    [SSAPI uploadSelfieWith768x768Image:img onComplete:^(NSString *newSelfieID, NSString *newSelfieURL, NSString *newSelfieThumbURL, NSError *error) {
        
        self.videolayer.connection.enabled = true;
        cameraImageView.image = nil;
        takepicturebutton.enabled = YES;
        
        if (error != nil) {
            NSLog(@"image upload error %@", error);
            
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:error.domain message:error.userInfo[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [v show];
        }
        
        
        
        [self.delegate pictureTakenViewSuccessfullyTookPicture:self];
    }];
    */
}

-(void)removePicture {
    self.videolayer.connection.enabled = true;
    cameraImageView.image = nil;
}




@end
