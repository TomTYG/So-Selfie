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
}

@end

@implementation VoteCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    voteStatus = 0;
    
    self.backgroundColor = [UIColor colorWithWhite:(float)0xf7/255.0 alpha:1];
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    self.photoImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.photoImageView];
    
    
    ratingButtonsController = [[VoteButtonView alloc] init];
    ratingButtonsController.delegate = self;
    ratingButtonsController.backgroundColor = [UIColor clearColor];
    ratingButtonsController.frame = CGRectMake(0, 320, 320, 248);
    [self addSubview:ratingButtonsController];
    
    self.facebookProfilePicture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 270, 38, 38)];
    self.facebookProfilePicture.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    [self addSubview:self.facebookProfilePicture];
    
    float x = 58;
    self.facebookNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 270, self.frame.size.width - x, 38)];
    self.facebookNameLabel.text = @"";
    self.facebookNameLabel.textAlignment = NSTextAlignmentLeft;
    self.facebookNameLabel.textColor = [UIColor blackColor];
    [self.facebookNameLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:14]];
    [self addSubview:self.facebookNameLabel];
    
    
    
    return self;
}

-(void)getRandomImage {
    //NSLog(@"getting random image %i", voteStatus);
    
    if (voteStatus != 0) return;
    
    voteStatus = 1;
    [SSAPI getRandomSelfieForMinimumAge:13 andMaximumAge:34 andGenders:(SSUserGenderMale | SSUserGenderFemale) onComplete:^(NSDictionary *imageData, NSError *error){
        
        if (error != nil) {
            NSLog(@"error getting random image %@", error);
            return;
        }
        
<<<<<<< HEAD
        currentImageData = imageData;
=======
        VoteButtonVIew *ratingButtonsController = [[VoteButtonVIew alloc] init];
        ratingButtonsController.backgroundColor = [UIColor clearColor];
        
        //iphone 4 or 5
        ratingButtonsController.frame = CGRectMake(0, 320, 320, 248);
        [self addSubview:ratingButtonsController];
>>>>>>> FETCH_HEAD
        
        NSString *userfbid = imageData[@"user"][@"fbid"];
        
        [SSAPI getProfilePictureOfUser:userfbid withSize:self.facebookProfilePicture.frame.size onComplete:^(UIImage *image, NSError *error){
            if (imageData != currentImageData) return;
            
            self.facebookProfilePicture.image = image;
        }];
        
<<<<<<< HEAD
        [SSAPI getUserFullName:userfbid onComplete:^(NSString *fullName, NSError *error){
            if (imageData != currentImageData) return;
            
            self.facebookNameLabel.text = fullName;
        }];
=======
        self.facebookNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 270, 100, 38)];
        self.facebookNameLabel.text = @"Facebook Name";
        self.facebookNameLabel.textAlignment = NSTextAlignmentCenter;
        self.facebookNameLabel.backgroundColor = [UIColor clearColor];
        self.facebookNameLabel.textColor = [UIColor blackColor];
        [self.facebookNameLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:14]];
        [self addSubview:self.facebookNameLabel];
>>>>>>> FETCH_HEAD
        
        
        
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
        self.delegate = nil;
        
        [ratingButtonsController prepareForReuse];
        
        [super prepareForReuse];
        voteStatus = 0;
    }
    
}


@end
