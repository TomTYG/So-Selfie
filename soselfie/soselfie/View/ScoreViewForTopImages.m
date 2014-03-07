//
//  ScoreViewForTopImages.m
//  soselfie
//
//  Created by TYG on 07/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "ScoreViewForTopImages.h"

@implementation ScoreViewForTopImages {
    

    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:0.5];
        
        //Labels
        
        int textsize = 15;
        int labelheight = 17;
        NSString *myriadBoldFont = @"MyriadPro-Bold";
        
        //soFunnyLine
        
        int y1 = 14;
        
        UILabel *soFunnyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,y1,100,labelheight)];
        soFunnyLabel.text = @"SO funny!";
        soFunnyLabel.textColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
        soFunnyLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        [self addSubview:soFunnyLabel];
        
        self.soFunnyVotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(soFunnyLabel.frame.size.width + 10, y1, 50, labelheight)];
        self.soFunnyVotesLabel.textColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
        self.soFunnyVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soFunnyVotesLabel.text = [NSString stringWithFormat:@"%d",self.soFunnyVotes];
        [self addSubview:self.soFunnyVotesLabel];
        
        /*
        self.soFunnyRankLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, y1, 50, labelheight)];
        self.soFunnyRankLabel.textColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
        self.soFunnyRankLabel.font = [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soFunnyRankLabel.text = [NSString stringWithFormat:@"#%d",self.soFunnyRank];
        [self addSubview:self.soFunnyRankLabel];
        */
        
        //soHotLine
        
        int y2 = 30;
        
        UILabel *soHotLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,y2,100,labelheight)];
        soHotLabel.text = @"SO hot!";
        soHotLabel.textColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
        soHotLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        [self addSubview:soHotLabel];
        
        self.soHotVotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(soHotLabel.frame.size.width + 10, y2, 50, labelheight)];
        self.soHotVotesLabel.textColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
        self.soHotVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soHotVotesLabel.text = [NSString stringWithFormat:@"%d",self.soHotVotes];
        [self addSubview:self.soHotVotesLabel];
        
        /*
        self.soHotRankLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, y2, 50, labelheight)];
        self.soHotRankLabel.textColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
        self.soHotRankLabel.font = [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soHotRankLabel.text = [NSString stringWithFormat:@"#%d",self.soHotRank];
        [self addSubview:self.soHotRankLabel];
        */
        
        //soLameLine
        
        int y3 = 46;
        
        UILabel *soLameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,y3,100,labelheight)];
        soLameLabel.text = @"SO lame!";
        soLameLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
        soLameLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        [self addSubview:soLameLabel];
        
        self.soLameVotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(soLameLabel.frame.size.width +10, y3, 50, labelheight)];
        self.soLameVotesLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
        self.soLameVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soLameVotesLabel.text = [NSString stringWithFormat:@"%d",self.soLameVotes];
        [self addSubview:self.soLameVotesLabel];
        
        /*
        self.soLameRankLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, y3, 50, labelheight)];
        self.soLameRankLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
        self.soLameRankLabel.font = [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soLameRankLabel.text = [NSString stringWithFormat:@"#%d",self.soLameRank];
        [self addSubview:self.soLameRankLabel];
        */
        
        //tryAgainLine
        
        int y4 = 62;
        
        UILabel *tryAgainLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,y4,100,labelheight)];
        tryAgainLabel.text = @"SO weird!";
        tryAgainLabel.textColor =[UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
        tryAgainLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        [self addSubview:tryAgainLabel];
        
        self.tryAgainVotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(tryAgainLabel.frame.size.width + 10,y4, 50, labelheight)];
        self.tryAgainVotesLabel.textColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
        self.tryAgainVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.tryAgainVotesLabel.text = [NSString stringWithFormat:@"%d",self.tryAgainVotes];
        [self addSubview:self.tryAgainVotesLabel];
        
        /*
        self.tryAgainRankLabel = [[UILabel alloc] initWithFrame:CGRectMake(280,y4, 50, labelheight)];
        self.tryAgainRankLabel.textColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
        self.tryAgainRankLabel.font = [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.tryAgainRankLabel.text = [NSString stringWithFormat:@"#%d",self.soLameRank];
        [self addSubview:self.tryAgainRankLabel];
        */
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
