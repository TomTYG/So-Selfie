//
//  RootOwnSelfiesViewCell.h
//  soselfie
//
//  Created by Tom van Kruijsbergen on 25/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootOwnSelfiesViewCell;

@protocol RootOwnSelfiesViewCellDelegate <NSObject>

@required
-(void)viewCellClickedEraseButton:(RootOwnSelfiesViewCell*)cell;

@end

@interface RootOwnSelfiesViewCell : UICollectionViewCell<UIAlertViewDelegate>

@property (weak) id<RootOwnSelfiesViewCellDelegate>delegate;
@property (weak) NSDictionary *data;

-(void)startWithData:(NSDictionary*)data;

@end
