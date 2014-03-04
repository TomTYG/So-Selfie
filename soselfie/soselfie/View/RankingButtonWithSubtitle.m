//
//  RankingButtonWithSubtitle.m
//  SoSelfie
//
//  Created by TYG on 27/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "RankingButtonWithSubtitle.h"

@implementation RankingButtonWithSubtitle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfVotes = 0;
        
        self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 160, 30)];
        [self.subtitleLabel setBackgroundColor:[UIColor clearColor]];
        self.subtitleLabel.textAlignment = NSTextAlignmentCenter; 
        [self.subtitleLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:13]];
        self.subtitleLabel.text= [NSString stringWithFormat:@"%d voted this",self.numberOfVotes];
        [self.subtitleLabel setTextColor:[UIColor blackColor]];
        [self addSubview:self.subtitleLabel];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
