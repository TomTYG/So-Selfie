//
//  GenericSoSelfieButtonWithOptionalSubtitle.m
//  soselfie
//
//  Created by TYG on 05/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "GenericSoSelfieButtonWithOptionalSubtitle.h"

@implementation GenericSoSelfieButtonWithOptionalSubtitle


- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)backgroundColor highlightColor:(UIColor *)highlightColor titleLabel:(NSString *)title withFontSize: (float) fontsize{
    
    self = [super initWithFrame:frame];
    
    self.subtitleLabel = [[UILabel alloc] init];
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
        
        self.subtitleLabel.frame = CGRectMake(0, 50, 160, 30);
    }
    else {
        
        self.subtitleLabel.frame = CGRectMake(0, 33, 160, 30);
        [self setTitleEdgeInsets:UIEdgeInsetsMake(5, 2, 0, 0)];
    }
    
    //self.backgroundColor = backgroundColor;
    [self setTitle:title forState:UIControlStateNormal];
    
    [self.subtitleLabel setBackgroundColor:[UIColor clearColor]];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:fontsize]];
    [self.subtitleLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:13]];
    [self.subtitleLabel setTextColor:[UIColor blackColor]];
    [self addSubview:self.subtitleLabel];
    
    [self setbackgroundColorNormal:backgroundColor];
    [self setbackgroundColorHighlighted:highlightColor];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    return self;
}

-(void)setNumberOfVotes:(int)numberOfVotes {
    self.subtitleLabel.text = [NSString stringWithFormat:@"%i voted this",numberOfVotes];
}


-(void)setbackgroundColorNormal:(UIColor*)color {
    [self setBackgroundImage:[self imageWithColor:color] forState:UIControlStateNormal];
}
-(void)setbackgroundColorHighlighted:(UIColor*)color {
    [self setBackgroundImage:[self imageWithColor:color] forState:UIControlStateHighlighted];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    
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
