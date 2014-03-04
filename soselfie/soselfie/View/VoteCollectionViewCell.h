//
//  VoteCollectionViewCell.h
//  SoSelfie
//
//  Created by TYG on 27/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingButtonsViewController.h"
#import "VoteButtonView.h"
#import "SSMacros.h"

@class VoteCollectionViewCell;

@protocol VoteCollectionViewCellDelegate <NSObject>

@required
-(void)voteCollectionViewCellDoneVoting:(VoteCollectionViewCell*)cell;

@end

@interface VoteCollectionViewCell : UICollectionViewCell<VoteButtonViewDelegate>

@property (strong, nonatomic) UIImageView *photoImageView;
@property (strong ,nonatomic) UIImageView *facebookProfilePicture;
@property (strong, nonatomic) UILabel *facebookNameLabel;

@property (weak) id<VoteCollectionViewCellDelegate>delegate;

-(void)getRandomImage;

@end
