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

//this method is called by the MasterViewController when it becomes visible. Since viewcontrollers are always on, this is a good way of checking what should happen when a view controller becomes visible.
-(void)becameVisible;

@end
