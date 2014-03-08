//
//  SSLoadingView.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 08/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "SSLoadingView.h"

@interface SSLoadingView() {
    UIImageView *loadingview;
    
    UILabel *loadingLabel;
    NSArray *images;
}

@end

@implementation SSLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    //self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    
    NSMutableArray *a = [[NSMutableArray alloc] init];
    [a addObject:[UIImage imageNamed:@"001"]];
    [a addObject:[UIImage imageNamed:@"002"]];
    [a addObject:[UIImage imageNamed:@"003"]];
    [a addObject:[UIImage imageNamed:@"004"]];
    [a addObject:[UIImage imageNamed:@"005"]];
    [a addObject:[UIImage imageNamed:@"006"]];
    [a addObject:[UIImage imageNamed:@"007"]];
    [a addObject:[UIImage imageNamed:@"008"]];
    
    
    
    UIImage *img = a[0];
    
    CGSize cs = img.size;
    cs.width *= 0.5;
    cs.height *= 0.5;
    
    float width = 150;
    
    images = a;
    
    loadingview = [[UIImageView alloc] initWithFrame:CGRectMake(0.5 * width - 0.5 * cs.width, 0, cs.width, cs.height)];
    [self addSubview:loadingview];
    loadingview.contentMode = UIViewContentModeScaleAspectFit;
    
    [loadingview setAnimationImages:images];
    [loadingview setAnimationDuration:1];
    [loadingview setAnimationRepeatCount:0];
    [loadingview startAnimating];
    
    float fontsize = 16;
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, loadingview.frame.origin.y + loadingview.frame.size.height + 12, width, fontsize + 4)];
    loadingLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    //loadingLabel.textColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.text = @"Wait just a sec...";
    [self addSubview:loadingLabel];
    
    CGRect cr = self.frame;
    cr.size.width = width;
    cr.size.height = loadingLabel.frame.origin.y + loadingLabel.frame.size.height;
    self.frame = cr;
    
    return self;
}


@end
