//
//  VoteCollectionViewCell.m
//  SoSelfie
//
//  Created by TYG on 27/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "VoteCollectionViewCell.h"
#import "SSAPI.h"

@interface VoteCollectionViewCell () {
    VoteButtonView *ratingButtonsController;
    NSDictionary *currentImageData;
    int voteStatus;
    
    
    UIImageView *facebookProfileBackground;
    UIImageView *shadowOverImagesView;
}

@end

@implementation VoteCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    voteStatus = 0;
    
    int tabBarHeight = 60;
    float facebookInfoY;
    
    self.backgroundColor = [UIColor colorWithWhite:(float)0xf7/255.0 alpha:1];
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    self.photoImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.photoImageView];
    
    
    shadowOverImagesView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"universalselfiepreview_shadow.png"]];
    shadowOverImagesView.contentMode = UIViewContentModeScaleAspectFit;
    CGRect cr = shadowOverImagesView.frame;
    cr.size.width *= 0.5;
    cr.size.height *= 0.5;
    cr.origin.y = self.photoImageView.frame.size.height + self.photoImageView.frame.origin.y - cr.size.height;
    shadowOverImagesView.frame = cr;
    [self addSubview:shadowOverImagesView];
    
    ratingButtonsController = [[VoteButtonView alloc] init];
    ratingButtonsController.delegate = self;
    ratingButtonsController.backgroundColor = [UIColor clearColor];
    
    
     if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
         ratingButtonsController.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - ratingButtonsController.soFunnyButton.frame.size.height*2 - tabBarHeight, 320, ratingButtonsController.soFunnyButton.frame.size.height*2);
         facebookInfoY = 270;
     }
     else {
         ratingButtonsController.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - ratingButtonsController.soFunnyButton.frame.size.height*2 - tabBarHeight - [UIApplication sharedApplication].statusBarFrame.size.height , 320, ratingButtonsController.soFunnyButton.frame.size.height*2);
         facebookInfoY = 230;
     }
    
    [self addSubview:ratingButtonsController];

    facebookProfileBackground = [[UIImageView alloc] initWithFrame:CGRectMake(10, facebookInfoY, 38, 38)];
    facebookProfileBackground.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    [self addSubview:facebookProfileBackground];
    
    
    self.facebookProfilePicture = [[UIImageView alloc] initWithFrame:CGRectMake(10, facebookInfoY, 38, 38)];
    self.facebookProfilePicture.backgroundColor = [UIColor clearColor];
    self.facebookProfilePicture.alpha = 0;
    [self addSubview:self.facebookProfilePicture];
    
    float x = 58;
    
    self.facebookNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, facebookInfoY, self.frame.size.width - x, 38)];
    self.facebookNameLabel.text = @"";
    self.facebookNameLabel.textAlignment = NSTextAlignmentLeft;
    self.facebookNameLabel.backgroundColor = [UIColor clearColor];
    self.facebookNameLabel.textColor = [UIColor whiteColor];
    [self.facebookNameLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:14]];
    self.facebookNameLabel.alpha = 0;
    [self addSubview:self.facebookNameLabel];
    
    
    
    return self;
}

-(void)getRandomImage {
    
    
    //NSLog(@"getting random image %i", voteStatus);
    
    if (voteStatus != 0) return;
    [ratingButtonsController disableButtons];
    
    voteStatus = 1;
    [SSAPI getRandomSelfieForMinimumAge:13 andMaximumAge:34 andGenders:(SSUserGenderMale | SSUserGenderFemale) onComplete:^(NSDictionary *imageData, NSError *error){
        
        //todo: this line enables the buttons to be used again even when there is an image error of some kind (like no access token, or like no more images available. consider what a good fallback might be instead of this solution.
        [ratingButtonsController enableButtons];
        
        currentImageData = imageData;
        if (error != nil) {
            //NSLog(@"error getting random image %@", error.domain);
            if ([error.domain isEqualToString:@"No more images"]) {
                //todo: spawn the "no images screen";
                NSLog(@"no more images!");
            }
            return;
        }
        
        
        NSString *userfbid = imageData[@"user"][@"fbid"];
        
        [SSAPI getProfilePictureOfUser:userfbid withSize:self.facebookProfilePicture.frame.size onComplete:^(UIImage *image, NSError *error){
            if (imageData != currentImageData) return;
            
            [UIView animateWithDuration:0.2 animations:^() {
                self.facebookProfilePicture.alpha = 1;
            }];
            
            self.facebookProfilePicture.image = image;
        }];
        [SSAPI getUserFullName:userfbid onComplete:^(NSString *fullName, NSError *error){
            if (imageData != currentImageData) return;
            
            self.facebookNameLabel.text = fullName;
            [UIView animateWithDuration:0.2 animations:^() {
                self.facebookNameLabel.alpha = 1;
            }];
        }];
        
        
        
        [SSAPI getImageWithImageURL:imageData[@"url_small"] onComplete:^(UIImage *image, NSError *error){
            if (imageData != currentImageData) return;
            
            self.photoImageView.image = image;
        }];
        
        
        
        //this disables the "X voted this" black text underneath buttons, by disabling it.
        //[ratingButtonsController startWithVotesDictionary:imageData];
    }];
}



-(void)voteButtonView:(VoteButtonView *)voteButtonView pressedButton:(UIButton *)button vote:(SSVoteType)vote {
    
    [SSAPI voteForSelfieID:currentImageData[@"id"] andImageAccessToken:currentImageData[@"accesstoken"] andVote:vote onComplete:^(BOOL success, NSError *possibleError){
        
        voteStatus = 2;
        //NSLog(@"voting done %@ %@", @(success), possibleError);
        [self.delegate voteCollectionViewCellDoneVoting:self];
        
    }];
}


-(void)prepareForReuse {
    //NSLog(@"preparing for reuse %i", voteStatus);
    if (voteStatus == 2) {
        self.facebookProfilePicture.image = nil;
        self.photoImageView.image = nil;
        self.facebookNameLabel.text = @"";
        self.facebookNameLabel.alpha = 0;
        self.delegate = nil;
        
        [ratingButtonsController prepareForReuse];
        
        [super prepareForReuse];
        voteStatus = 0;
    }
    
    
}


@end
