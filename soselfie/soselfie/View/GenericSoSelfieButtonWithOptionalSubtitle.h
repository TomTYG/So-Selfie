//
//  GenericSoSelfieButtonWithOptionalSubtitle.h
//  soselfie
//
//  Created by TYG on 05/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMacros.h"

@interface GenericSoSelfieButtonWithOptionalSubtitle : UIButton

@property (strong, nonatomic) UILabel *subtitleLabel;
-(void)setNumberOfVotes:(int)numberOfVotes;

- (UIImage *)imageWithColor:(UIColor *)color;
- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)backgroundColor highlightColor:(UIColor *)highlightColor titleLabel:(NSString *)title withFontSize: (float) fontsize;

@end
