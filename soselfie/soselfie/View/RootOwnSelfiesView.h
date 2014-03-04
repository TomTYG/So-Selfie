//
//  RootOwnSelfiesView.h
//  soselfie
//
//  Created by Tom van Kruijsbergen on 25/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootOwnSelfiesViewCell.h"

@interface RootOwnSelfiesView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, RootOwnSelfiesViewCellDelegate>

-(void)refreshData;

@end
