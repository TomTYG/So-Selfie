//
//  YourSelfiesController.h
//  SoSelfie
//
//  Created by TYG on 28/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfiesCollectionViewCell.h"
#import "TabBarView.h"


@interface YourSelfiesController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *yourSelfiesCollectionView;
@property (strong, nonatomic) TabBarView *tabBarView;
@property (strong, nonatomic) NSArray *testDataArray; 


@end
