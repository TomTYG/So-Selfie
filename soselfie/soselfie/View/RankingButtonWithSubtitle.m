//
//  RankingButtonWithSubtitle.m
//  SoSelfie
//
//  Created by TYG on 27/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "RankingButtonWithSubtitle.h"

@interface RankingButtonWithSubtitle() {
    
}



@end

@implementation RankingButtonWithSubtitle


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.subtitleLabel = [[UILabel alloc] init];
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
        
        self.subtitleLabel.frame = CGRectMake(0, 50, 160, 30);
    }
    else {
        
        self.subtitleLabel.frame = CGRectMake(0, 33, 160, 30);
        
    }
    
    
    [self.subtitleLabel setBackgroundColor:[UIColor clearColor]];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.subtitleLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:13]];
    [self.subtitleLabel setTextColor:[UIColor blackColor]];
    [self addSubview:self.subtitleLabel];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)backgroundColor highlightColor:(UIColor *)highlightColor titleLabel:(NSString *)title{
    
    self = [super initWithFrame:frame];
    
    self.subtitleLabel = [[UILabel alloc] init];
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
        
        self.subtitleLabel.frame = CGRectMake(0, 50, 160, 30);
    }
    else {
        
        self.subtitleLabel.frame = CGRectMake(0, 33, 160, 30);
        //[self setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
    }
    
    
    [self.subtitleLabel setBackgroundColor:[UIColor clearColor]];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.subtitleLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:13]];
    [self.subtitleLabel setTextColor:[UIColor blackColor]];
    [self addSubview:self.subtitleLabel];
    
    return self;
}

-(void)setNumberOfVotes:(int)numberOfVotes {
    self.subtitleLabel.text = [NSString stringWithFormat:@"%i voted this",numberOfVotes];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
