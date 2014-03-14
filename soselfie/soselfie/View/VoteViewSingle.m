//
//  VoteViewSingle.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 11/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "VoteViewSingle.h"

@interface VoteViewSingle() {
    
    VoteButtonView *ratingButtonsController;
    
    UIImageView *facebookProfileBackground;
    UIImageView *facebookProfilePicture;
    UILabel *facebookNameLabel;
    
    UIImageView *photoImageView;
    UIImageView *shadowOverImagesView;
    UIButton *innapropriateImageButton;
    
    
    BOOL canVote;
}

@property (weak) NSDictionary *imageData;


@end

@implementation VoteViewSingle

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    canVote = YES;
    
    
    self.backgroundColor = [UIColor colorWithWhite:(float)0xf7/255.0 alpha:1];
    photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    photoImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:photoImageView];
    
    
    shadowOverImagesView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"universalselfiepreview_shadow.png"]];
    shadowOverImagesView.contentMode = UIViewContentModeScaleAspectFit;
    CGRect cr = shadowOverImagesView.frame;
    cr.size.width *= 0.5;
    cr.size.height *= 0.5;
    cr.origin.y = photoImageView.frame.size.height + photoImageView.frame.origin.y - cr.size.height;
    shadowOverImagesView.frame = cr;
    [self addSubview:shadowOverImagesView];
    
    float height = photoImageView.frame.size.height + photoImageView.frame.origin.y;
    
    ratingButtonsController = [[VoteButtonView alloc] initWithFrame:CGRectMake(0, height, self.frame.size.width, self.frame.size.height - height)];
    ratingButtonsController.delegate = self;
    ratingButtonsController.backgroundColor = [UIColor clearColor];
    [self addSubview:ratingButtonsController];
    
    height = photoImageView.frame.size.height - 38 - 8;
    facebookProfileBackground = [[UIImageView alloc] initWithFrame:CGRectMake(10, height, 38, 38)];
    facebookProfileBackground.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    facebookProfileBackground.contentMode = UIViewContentModeScaleAspectFit;
    facebookProfileBackground.image = [UIImage imageNamed:@"iphone4_shootbutton"];
    [self addSubview:facebookProfileBackground];
    
    
    facebookProfilePicture = [[UIImageView alloc] initWithFrame:facebookProfileBackground.frame];
    facebookProfilePicture.backgroundColor = [UIColor clearColor];
    facebookProfilePicture.alpha = 0;
    [self addSubview:facebookProfilePicture];
    
    float x = 58;
    
    facebookNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, height, self.frame.size.width - x, 38)];
    facebookNameLabel.text = @"";
    facebookNameLabel.textAlignment = NSTextAlignmentLeft;
    facebookNameLabel.backgroundColor = [UIColor clearColor];
    facebookNameLabel.textColor = [UIColor whiteColor];
    [facebookNameLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:14]];
    facebookNameLabel.alpha = 0;
    [self addSubview:facebookNameLabel];
    
    int buttonWidth = 35;
    int buttonHeight = 35;
    
    innapropriateImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    innapropriateImageButton.alpha = 0.8;
    innapropriateImageButton.frame = CGRectMake(self.frame.size.width - buttonWidth - 10, height + 3,buttonWidth, buttonHeight);
    
    [innapropriateImageButton setBackgroundImage:[UIImage imageNamed:@"inappropriate"] forState:UIControlStateNormal];
    [innapropriateImageButton setBackgroundImage:[UIImage imageNamed:@"inappropriate_red"] forState:UIControlStateHighlighted];
    [innapropriateImageButton setBackgroundImage:[UIImage imageNamed:@"inappropriate_red"] forState:UIControlStateSelected];
    
    [self addSubview:innapropriateImageButton];
    
    [innapropriateImageButton addTarget:self action:@selector(markAsInnapropriate:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [ratingButtonsController enableButtons];
    
    return self;
}

-(void)startWithImageData:(NSDictionary *)imageData {
    
    //if (currentImageData == imageData) return;
    
    NSLog(@"starting with image data %@", imageData[@"id"]);
    
    //facebookProfilePicture.image = nil;
    //photoImageView.image = nil;
    facebookNameLabel.text = @"";
    facebookNameLabel.alpha = 0;
    
    self.imageData = imageData;
    
    NSString *userfbid = imageData[@"user"][@"fbid"];
    
    [SSAPI getProfilePictureOfUser:userfbid withSize:facebookProfilePicture.frame.size onComplete:^(UIImage *image, NSError *error){
        if (imageData != self.imageData) return;
        
        [UIView animateWithDuration:0.2 animations:^() {
            facebookProfilePicture.alpha = 1;
        }];
        
        facebookProfilePicture.image = image;
    }];
    [SSAPI getUserFullName:userfbid onComplete:^(NSString *fullName, NSError *error){
        if (imageData != self.imageData) return;
        
        facebookNameLabel.text = fullName;
        [UIView animateWithDuration:0.2 animations:^() {
            facebookNameLabel.alpha = 1;
        }];
    }];
    
    
    
    [SSAPI getImageWithImageURL:imageData[@"url_small"] onComplete:^(UIImage *image, NSError *error){
        if (imageData != self.imageData) return;
        
        photoImageView.image = image;
    }];
}


- (void)markAsInnapropriate:(UIButton *)button {
    
    //button.highlighted = YES;
    //button.selected = YES;
    
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"This Selfie is not ok" message:@"Report as inappropriate?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [v show];
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    //innapropriateImageButton.highlighted = NO;
    //innapropriateImageButton.selected = NO;
    
    if (buttonIndex == 0) return;
    
    [self voteButtonView:nil pressedButton:innapropriateImageButton vote:SSVoteTypeInappropriate];
    
}


-(void)voteButtonView:(VoteButtonView *)voteButtonView pressedButton:(UIButton *)button vote:(SSVoteType)vote {
    button.selected = YES;
    
    [self.delegate voteViewSingle:self clickedVote:vote];
}

@end
