//
//  RankingButtonWithSubtitle.h
//  SoSelfie
//
//  Created by TYG on 27/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMacros.h"

@interface RankingButtonWithSubtitle : UIButton

@property (strong, nonatomic) UILabel *subtitleLabel;
-(void)setNumberOfVotes:(int)numberOfVotes;


+ (UIImage *)imageWithColor:(UIColor *)color;

@end
