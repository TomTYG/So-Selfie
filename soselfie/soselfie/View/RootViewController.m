//
//  RootViewController.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 18/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "RootViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SSAPI.h"

@interface RootViewController ()

@end

@implementation RootViewController

-(void)viewDidLoad {
    
    float width = self.view.bounds.size.width;
    float height = 100;
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0.5 * self.view.bounds.size.width - 0.5 * width, self.view.bounds.size.height - height, width, height)];
    [b addTarget:self action:@selector(buttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [b setTitle:@"Login with Facebook" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [self.view addSubview:b];
    
    if ([FBSession activeSession].state == FBSessionStateCreatedTokenLoaded) {
        NSArray *permissions = @[@"user_birthday"];
        
        [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:NO completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
            
            if (error != nil){
                NSLog(@"error %@", error);
                return;
            }
            
            //NSLog(@"session token %@", session.accessTokenData.accessToken);
            
            //[self sessionStateChanged:session state:state error:error];
            
        }];
    }
}

-(void)buttonclicked:(id)sender {
    
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError* error) {
        
        NSString *fbid = result[@"id"];
        
        //temp code that creates an image with predefined background.
        UIColor *color = [UIColor redColor];
        CGRect rect = CGRectMake(0, 0, 320, 320);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [SSAPI uploadSelfieForFBid:fbid andAccessToken:[FBSession activeSession].accessTokenData.accessToken andImage:image onComplete:nil];
        
        
    }];
    
    
    if ([FBSession activeSession].state & FB_SESSIONSTATEOPENBIT) return;
    
    NSArray *permissions = @[@"user_birthday"];
    
    [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
        
        if (error != nil){
            NSLog(@"error %@", error);
            return;
        }
        
        NSLog(@"login worked %i", state);
        //[self sessionStateChanged:session state:state error:error];
        
    }];
    
}

@end
