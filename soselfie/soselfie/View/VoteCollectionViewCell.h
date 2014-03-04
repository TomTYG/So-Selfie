//
//  VoteCollectionViewCell.h
//  SoSelfie
//
//  Created by TYG on 27/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingButtonsViewController.h"
#import "VoteButtonVIew.h"
#import "SSMacros.h"

@interface VoteCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *photoImageView;
@property (strong ,nonatomic) UIImageView *facebookProfilePicture;
@property (strong, nonatomic) UILabel *facebookNameLabel; 

@end
