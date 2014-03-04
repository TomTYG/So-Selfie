//
//  VoteViewController.h
//  SoSelfie
//
//  Created by TYG on 26/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingButtonsViewController.h"
#import "VoteCollectionViewCell.h"
#import "TabBarView.h"


@interface VoteViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, VoteCollectionViewCellDelegate>

@property (strong, nonatomic) UICollectionView *mainVoteCollectionView;
//@property (strong , nonatomic) NSArray *testArray;
@property (strong, nonatomic) TabBarView *tabBarView;


@end
