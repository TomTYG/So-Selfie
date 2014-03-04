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
    
    
    self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 160, 30)];
    [self.subtitleLabel setBackgroundColor:[UIColor clearColor]];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.subtitleLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:13]];
    
    self.subtitleLabel.text=@"";
    [self.subtitleLabel setTextColor:[UIColor blackColor]];
    [self addSubview:self.subtitleLabel];
    
    return self;
}

-(void)setNumberOfVotes:(int)numberOfVotes {
    self.subtitleLabel.text = [NSString stringWithFormat:@"%i voted this",numberOfVotes];
}


@end
