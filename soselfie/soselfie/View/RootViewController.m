//
//  RootViewController.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 18/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//


#import "RootViewController.h"
#import "RootOwnSelfiesView.h"
#import "RootVoteSelfieView.h"
#import "RootAgesPickerView.h"
#import "RootPictureTakerView.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SSAPI.h"

@interface RootViewController () {
    
    UIScrollView *mainscrollview;
    
    UISwitch *boysSwitch;
    UISwitch *girlSwitch;
    
    
    
    UILabel *loggedinID;
    
    UITextField *uploadimgfield;
    UIButton *uploadimagebutton;
    
    
    RootOwnSelfiesView *ownselfiesview;
    RootVoteSelfieView *voteselfieview;
    RootAgesPickerView *agesview;
    RootPictureTakerView *picturetakeview;
    
    int minimumAge;
    int maximumAge;
    SSUserGender genders;
}



@end

@implementation RootViewController

-(void)viewDidLoad {
    
    mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainscrollview.contentSize = CGSizeMake(0, mainscrollview.frame.size.height * 5);
    [self.view addSubview:mainscrollview];
    
    float width = self.view.bounds.size.width;
    UIButton *b;
    
    const float MARGIN = 6;
    float height = 30;
    
    b = [[UIButton alloc] initWithFrame:CGRectMake(0.5 * self.view.bounds.size.width - 0.5 * width, 30, width, 40)];
    [b addTarget:self action:@selector(loginbuttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [b setTitle:@"Login with Facebook" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [mainscrollview addSubview:b];
    
    height = b.frame.origin.y + b.frame.size.height + MARGIN;
    
    float fontsize = 12;
    
    loggedinID = [[UILabel alloc] initWithFrame:CGRectMake(0.5 * self.view.bounds.size.width - 0.5 * width, height, width, fontsize + 4)];
    loggedinID.textColor = [UIColor colorWithWhite:(float)0x99/255.0 alpha:1];
    loggedinID.font = [UIFont systemFontOfSize:fontsize];
    loggedinID.textAlignment = NSTextAlignmentCenter;
    loggedinID.text = @"";
    [mainscrollview addSubview:loggedinID];
    
    height = loggedinID.frame.origin.y + loggedinID.frame.size.height + MARGIN;
    
    
    b = [[UIButton alloc] initWithFrame:CGRectMake(0.5 * self.view.bounds.size.width - 0.5 * width, height, width, 40)];
    [b addTarget:self action:@selector(logoutbuttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [b setTitle:@"Logout" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [mainscrollview addSubview:b];
    
    height = b.frame.origin.y + b.frame.size.height + MARGIN;
    
    boysSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(30, height, 0, 0)];
    boysSwitch.onTintColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
    boysSwitch.thumbTintColor = [UIColor blueColor];
    [boysSwitch addTarget:self action:@selector(boysSwitchFlipped:) forControlEvents:UIControlEventValueChanged];
    [boysSwitch setOn:YES animated:NO];
    [mainscrollview addSubview:boysSwitch];
    
    girlSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(30, height, 0, 0)];
    CGRect cr = girlSwitch.frame;
    cr.origin.x = width - 30 - cr.size.width;
    girlSwitch.frame = cr;
    girlSwitch.thumbTintColor = [UIColor purpleColor];
    girlSwitch.onTintColor = [UIColor colorWithRed:1 green:83.0/255.0 blue:1 alpha:1];
    [girlSwitch addTarget:self action:@selector(girlSwitchFlipped:) forControlEvents:UIControlEventValueChanged];
    [girlSwitch setOn:YES animated:NO];
    [mainscrollview addSubview:girlSwitch];
    
    genders = SSUserGenderMale | SSUserGenderFemale;
    
    height = boysSwitch.frame.origin.y + boysSwitch.frame.size.height + MARGIN;
    
    agesview = [[RootAgesPickerView alloc] initWithFrame:CGRectMake(0, height, width, 180)];
    [mainscrollview addSubview:agesview];
    
    height = agesview.frame.origin.y + agesview.frame.size.height;
    
    fontsize = 20;
    uploadimgfield = [[UITextField alloc] initWithFrame:CGRectMake(0, height, mainscrollview.frame.size.width, fontsize + 4)];
    uploadimgfield.textAlignment = NSTextAlignmentCenter;
    uploadimgfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    uploadimgfield.autocorrectionType = UITextAutocorrectionTypeNo;
    uploadimgfield.delegate = self;
    uploadimgfield.layer.borderColor = [UIColor blackColor].CGColor;
    uploadimgfield.layer.borderWidth = 1;
    [mainscrollview addSubview:uploadimgfield];
    
    height = uploadimgfield.frame.origin.y + uploadimgfield.frame.size.height + MARGIN;
    
    uploadimagebutton = [[UIButton alloc] initWithFrame:CGRectMake(0, height, mainscrollview.frame.size.width
                                                                   , mainscrollview.frame.size.width)];
    [uploadimagebutton addTarget:self action:@selector(imagebuttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    uploadimagebutton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [mainscrollview addSubview:uploadimagebutton];
    
    height = uploadimagebutton.frame.origin.y + uploadimagebutton.frame.size.height + MARGIN;
    
    picturetakeview = [[RootPictureTakerView alloc] initWithFrame:CGRectMake(0, height, width, 400)];
    picturetakeview.delegate = self;
    [mainscrollview addSubview:picturetakeview];
    
    height = picturetakeview.frame.origin.y + picturetakeview.frame.size.height;
    
    
    b = [[UIButton alloc] initWithFrame:CGRectMake(0, height, width, 40)];
    [b addTarget:self action:@selector(updateOwnSelfiesButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [b setTitle:@"Refresh own selfies" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [mainscrollview addSubview:b];
    
    height = b.frame.origin.y + b.frame.size.height + MARGIN;
    
    ownselfiesview = [[RootOwnSelfiesView alloc] initWithFrame:CGRectMake(0, height, mainscrollview.frame.size.width, mainscrollview.frame.size.height - 100)];
    [mainscrollview addSubview:ownselfiesview];
    
    height = ownselfiesview.frame.origin.y + ownselfiesview.frame.size.height + MARGIN;
    
    //frame is set by this class.
    voteselfieview = [[RootVoteSelfieView alloc] initWithFrame:CGRectMake(0, height, width, 0)];
    voteselfieview.delegate = self;
    [mainscrollview addSubview:voteselfieview];
    
    height = voteselfieview.frame.origin.y + voteselfieview.frame.size.height + MARGIN;
    
    b = [[UIButton alloc] initWithFrame:CGRectMake(0, height, width, 40)];
    [b setTitle:@"Get top selfies" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [b addTarget:self action:@selector(getTopSelfiesButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [mainscrollview addSubview:b];
}

-(void)loginbuttonclicked:(id)sender {
    
    //NSLog(@"logging in");
    
    [SSAPI logInToFacebookOnComplete:^(NSString *fbid, NSString *accessToken, BOOL couldRetrieveGender, BOOL couldRetrieveBirthday, NSError *error) {
        
        if (error != nil) {
            //NSLog(@"fb login error %@", error);
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:error.domain message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [v show];
            return;
        }
        
        loggedinID.text = fbid;
        
        if ([SSAPI isProfileInfoReadyToBeSentToServer].count > 0) {
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Login incomplete" message:[NSString stringWithFormat:@"Missing info: %@", [SSAPI isProfileInfoReadyToBeSentToServer]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [v show];
            return;
        }
        
        //temp functionality to illustrate how you would go about setting the birthday and gender values if they aren't detected by Facebook.
        //if (couldRetrieveBirthday == false) [SSAPI setUserBirthday:@"08" month:@"06" year:@"1988"];
        //if (couldRetrieveGender == false) [SSAPI setUserGender:SSUserGenderMale];
        
        
        
        [SSAPI sendProfileInfoToServerWithonComplete:^(BOOL success, NSError *possibleError) {
            NSLog(@"sent stuff to server: %@ %@", @(success), possibleError);
            
            [voteselfieview getRandomSelfie];
            
        }];
        
        
    }];
    
    
}
-(void)logoutbuttonclicked:(id)sender {
    loggedinID.text = @"";
    [[FBSession activeSession] closeAndClearTokenInformation];
}




-(int)voteSelfieViewNeedsGenders:(RootVoteSelfieView *)voteSelfieView {
    return genders;
}
-(int)voteSelfieViewNeedsMaximumAge:(RootVoteSelfieView *)voteSelfieView {
    return [agesview getmaximumage];
}
-(int)voteSelfieViewNeedsMinimumAge:(RootVoteSelfieView *)voteSelfieView {
    return [agesview getminimumage];
}





-(void)boysSwitchFlipped:(id)sender {
    UISwitch *s = (UISwitch*)sender;
    
    if (s.on == true) {
        genders = genders | SSUserGenderMale;
    } else {
        genders = genders ^ SSUserGenderMale;
    }
    
}
-(void)girlSwitchFlipped:(id)sender {
    UISwitch *s = (UISwitch*)sender;
    
    if (s.on == true) {
        genders = genders | SSUserGenderFemale;
    } else {
        genders = genders ^ SSUserGenderFemale;
    }
}







-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    
    NSString *s = [NSString stringWithFormat:@"%@.jpg", textField.text];
    UIImage *image = [UIImage imageNamed:s];
    if (image == nil) {
        textField.text = @"";
        UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"No valid image" message:[NSString stringWithFormat:@"No image exists called %@", s] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [v show];
        return NO;
    }
    
    
    //applies a random color filter over an image to allow you to upload a bunch of reasonably identical images while maintaining a difference. taken from http://stackoverflow.com/questions/6683822/ios-applying-a-rgb-filter-to-a-greyscale-png
    
    CGSize targetSize = image.size;
    CGRect rect = (CGRect){ .size = targetSize };
    
    UIImage *newImage;
    UIGraphicsBeginImageContext( targetSize );
    {
        CGContextRef X = UIGraphicsGetCurrentContext();
        
        //draw image
        [image drawInRect: rect];
        
        // overlay a rectangle of random color
        CGContextSetBlendMode( X, kCGBlendModeColor ) ;
        CGContextSetRGBFillColor ( X,  [self randomNumber], [self randomNumber], [self randomNumber],  1);
        CGContextFillRect ( X, rect );
        
        // redraw image
        [image drawInRect: rect
                blendMode: kCGBlendModeDestinationIn
                    alpha: 1];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    
    [uploadimagebutton setImage:newImage forState:UIControlStateNormal];
    
    return NO;
}
-(float)randomNumber {
    float f = arc4random_uniform(90) / (float)100;
    return f;
}
-(void)imagebuttonclicked:(id)sender {
    UIButton *b = (UIButton*)sender;
    UIImage *img = b.imageView.image;
    if (img == nil) {
        //NSLog(@"image nil");
        return;
    }
    
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Upload image?" message:[NSString stringWithFormat:@"Upload image %@.jpg?", uploadimgfield.text] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [v show];
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) return;
    
    
    
    [SSAPI uploadSelfieWith768x768Image:uploadimagebutton.imageView.image onComplete:^(NSString* newSelfieID, NSString *newSelfieURL, NSString *newSelfieThumbURL, NSError *error) {
        
        if (error != nil) {
            NSLog(@"image upload error %@", error);
            
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:error.domain message:error.userInfo[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [v show];
            return;
        }
        
        NSLog(@"image uploaded %@ %@ %@", newSelfieID, newSelfieURL, newSelfieThumbURL);
        
    }];
}



-(void)pictureTakenViewSuccessfullyTookPicture:(RootPictureTakerView *)pictureTakerView {
    [ownselfiesview refreshData];
}








-(void)updateOwnSelfiesButtonClicked:(id)sender {
    [ownselfiesview refreshData];
}

-(void)getTopSelfiesButtonClicked:(id)sender {
    [SSAPI getTopSelfiesForMinimumAge:[agesview getminimumage] andMaximumAge:[agesview getmaximumage] andGenders:genders andVoteCategory:SSVoteTypeFunny startingFromIndex:0 onComplete:^(int totalSelfies, NSArray *images, NSError *error){
        
        if (error != nil) {
            NSLog(@"top selfie get error %@", error);
            
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:error.domain message:error.userInfo[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [v show];
            return;
        }
        
        //NSLog(@"total %i images %@", totalSelfies, images);
        
    }];
}



@end
