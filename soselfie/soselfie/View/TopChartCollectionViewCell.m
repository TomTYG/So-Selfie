//
//  TopChartCollectionViewCell.m
//  SoSelfie
//
//  Created by TYG on 03/03/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "TopChartCollectionViewCell.h"

@implementation TopChartCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selfieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        [self addSubview:self.selfieImageView];
        
        self.rankingPlace = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 80, 40)];
        self.rankingPlace.backgroundColor = [UIColor clearColor];
        [self.rankingPlace setFont:[UIFont fontWithName:@"Tondu-Beta" size:40]];
        self.rankingPlace.textColor = [UIColor blackColor];
        self.rankingPlace.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.rankingPlace];
        
        self.facebookProfilePicture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 270, 38, 38)];
        self.facebookProfilePicture.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
        [self addSubview:self.facebookProfilePicture];
        
       
        self.facebookNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 270, 100, 38)];
        self.facebookNameLabel.text = @"Facebook Name";
        self.facebookNameLabel.backgroundColor = [UIColor clearColor];
        self.facebookNameLabel.textAlignment = NSTextAlignmentCenter;
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
