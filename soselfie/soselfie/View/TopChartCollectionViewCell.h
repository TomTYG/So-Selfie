//
//  TopChartCollectionViewCell.h
//  SoSelfie
//
//  Created by TYG on 03/03/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingButtonsViewController.h" 
#import "ScoreViewForTopImages.h"

@interface TopChartCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *selfieImageView;
@property (strong, nonatomic) UILabel *rankingPlace;
@property (strong, nonatomic) UIImageView *facebookProfilePicture;
@property (strong, nonatomic) UILabel *facebookNameLabel;
@property (strong, nonatomic) ScoreViewForTopImages *scoreViewForTopImages;


-(void)startWithImageData:(NSDictionary*)imageData;
-(void) displayScoreViewOnTap;


@end
