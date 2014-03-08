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
        
    self.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
    
    //Labels
    
    int textsize = 15;
    //int labelheight = 17;
    NSString *myriadBoldFont = @"MyriadPro-Bold";
    
    float MARGIN = 5;
    
    CGRect cr = CGRectMake(self.frame.size.width - 40 - MARGIN, MARGIN, 40, textsize + 2);
    
    CGRect cr2 = CGRectMake(MARGIN, MARGIN, 80, textsize + 2);
    
    
    
    //soFunnyLine
    
    //int y1 = 14;
    
    UILabel *soFunnyLabel = [[UILabel alloc] initWithFrame:cr2];
    soFunnyLabel.text = @"SO funny!";
    soFunnyLabel.textColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
    soFunnyLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
    soFunnyLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:soFunnyLabel];
    
    
    self.soFunnyVotesLabel = [[UILabel alloc] initWithFrame:cr];
    self.soFunnyVotesLabel.textColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
    self.soFunnyVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
    self.soFunnyVotesLabel.backgroundColor = [UIColor clearColor];
    self.soFunnyVotesLabel.textAlignment = NSTextAlignmentRight;
    
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
    
    //int y2 = 30;
    
    cr2.origin.y += cr2.size.height + MARGIN;
    cr.origin.y += cr2.size.height + MARGIN;
    
    UILabel *soHotLabel = [[UILabel alloc] initWithFrame:cr2];
    soHotLabel.text = @"SO hot!";
    soHotLabel.textColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    soHotLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
    soHotLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:soHotLabel];
    
    self.soHotVotesLabel = [[UILabel alloc] initWithFrame:cr];
    self.soHotVotesLabel.textColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    self.soHotVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
    self.soHotVotesLabel.backgroundColor = [UIColor clearColor];
    self.soHotVotesLabel.textAlignment = NSTextAlignmentRight;
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
    
    //int y3 = 46;
    
    cr2.origin.y += cr2.size.height + MARGIN;
    cr.origin.y += cr2.size.height + MARGIN;
    
    UILabel *soLameLabel = [[UILabel alloc] initWithFrame:cr2];
    soLameLabel.text = @"SO lame!";
    soLameLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
    soLameLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
    soLameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:soLameLabel];
    
    self.soLameVotesLabel = [[UILabel alloc] initWithFrame:cr];
    self.soLameVotesLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
    self.soLameVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
    self.soLameVotesLabel.backgroundColor = [UIColor clearColor];
    self.soLameVotesLabel.textAlignment = NSTextAlignmentRight;
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
    
    //int y4 = 62;
    
    cr2.origin.y += cr2.size.height + MARGIN;
    cr.origin.y += cr2.size.height + MARGIN;
    
    UILabel *tryAgainLabel = [[UILabel alloc] initWithFrame:cr2];
    tryAgainLabel.text = @"SO weird!";
    tryAgainLabel.textColor =[UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
    tryAgainLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
    tryAgainLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:tryAgainLabel];
    
    self.tryAgainVotesLabel = [[UILabel alloc] initWithFrame:cr];
    self.tryAgainVotesLabel.textColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
    self.tryAgainVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
    self.tryAgainVotesLabel.backgroundColor = [UIColor clearColor];
    self.tryAgainVotesLabel.textAlignment = NSTextAlignmentRight;
    //self.tryAgainVotesLabel.text = [NSString stringWithFormat:@"%d",self.tryAgainVotes];
    [self addSubview:self.tryAgainVotesLabel];
    
    cr2.origin.y += cr2.size.height + MARGIN;
    
    CGRect c = self.frame;
    c.size.height = cr2.origin.y;
    self.frame = c;
    
        /*
        self.tryAgainRankLabel = [[UILabel alloc] initWithFrame:CGRectMake(280,y4, 50, labelheight)];
        self.tryAgainRankLabel.textColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
        self.tryAgainRankLabel.font = [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.tryAgainRankLabel.text = [NSString stringWithFormat:@"#%d",self.soLameRank];
        [self addSubview:self.tryAgainRankLabel];
        */
    
    return self;
}


@end
