//
//  VoteCollectionViewCell.m
//  SoSelfie
//
//  Created by TYG on 27/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "VoteCollectionViewCell.h"

@implementation VoteCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        self.photoImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.photoImageView];
        
        
        VoteButtonVIew *ratingButtonsController = [[VoteButtonVIew alloc] init];
        ratingButtonsController.backgroundColor = [UIColor clearColor];
        
        //iphone 4 or 5
        ratingButtonsController.frame = CGRectMake(0, 320, 320, 248);
        [self addSubview:ratingButtonsController];
        
        self.facebookProfilePicture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 270, 38, 38)];
        self.facebookProfilePicture.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
        [self addSubview:self.facebookProfilePicture];
        
        
        self.facebookNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 270, 100, 38)];
        self.facebookNameLabel.text = @"Facebook Name";
        self.facebookNameLabel.textAlignment = NSTextAlignmentCenter;
        self.facebookNameLabel.backgroundColor = [UIColor clearColor];
        self.facebookNameLabel.textColor = [UIColor blackColor];
        [self.facebookNameLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:14]];
        [self addSubview:self.facebookNameLabel];
        
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
