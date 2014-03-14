//
//  SSDropDownView.h
//  soselfie
//
//  Created by Tom van Kruijsbergen on 13/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSDropDownView;

@protocol SSDropDownViewDelegate <NSObject>

@required
-(void)dropDownView:(SSDropDownView*)dropDownView clickedIndex:(int)index;

@end

@interface SSDropDownView : UIView <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (weak)id<SSDropDownViewDelegate>delegate;
@property NSArray *items;

//this array should contain, per entry, a NSDictionary with a "name", "color", "colorHighlighted" key.
-(instancetype)initWithFrame:(CGRect)frame andCellSize:(CGSize)cellSize andNameAndColorsArray:(NSArray*)array;

-(void)setDropDownMenuVisibility:(BOOL)visibility instant:(BOOL)instant;
-(void)selectIndex:(int)index triggerDelegate:(BOOL)triggerDelegate;

@end
