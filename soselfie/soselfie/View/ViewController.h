//
//  ViewController.h
//  SoSelfie
//
//  Created by TYG on 17/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"
#import "RatingButtonsViewController.h"
#import "DropDownMenu.h"
#import "MainSwipeMenuController.h"
#import "TopChartCollectionViewCell.h"
#import "SSMacros.h"
#import "VoteButtonView.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UITableViewDelegate, RatingButtonsViewControllerDelegate>

@property (strong, nonatomic) UICollectionView *topChartCollectionView;
@property (strong, nonatomic) RatingButtonsViewController *ratingButtonsController;
@property (strong, nonatomic) DropDownMenu *dropDownMenu;
@property (strong, nonatomic) TabBarView *tabBarView;


-(void)becameVisible;

@end
