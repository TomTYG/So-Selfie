//
//  TopChartCollectionViewCell.m
//  SoSelfie
//
//  Created by TYG on 03/03/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "TopChartCollectionViewCell.h"
#import "TopChartCollectionViewLayoutAttributes.h"
#import "SSAPI.h"


@interface TopChartCollectionViewCell () {
    
    
    UIImageView *facebookProfileBackground;
    UIImageView *shadowOverImagesView;
    
    UILabel *labelvotes;
    UILabel *labelrank;
    
    UILabel *labelsofunny;
    UILabel *labelsohot;
    UILabel *labelsolame;
    UILabel *labelsoweird;
    
    UILabel *labelranksofunny;
    UILabel *labelranksohot;
    UILabel *labelranksolame;
    UILabel *labelranksoweird;
    
}

@property (weak) NSDictionary *imageData;

@end

@implementation TopChartCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.clipsToBounds = YES;
    
    self.open = false;
    
    self.selfieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self addSubview:self.selfieImageView];
    
    self.rankingPlace = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 160, 40)];
    self.rankingPlace.backgroundColor = [UIColor clearColor];
    [self.rankingPlace setFont:[UIFont fontWithName:@"Tondu-Beta" size:40]];
    self.rankingPlace.textColor = [UIColor blackColor];
    self.rankingPlace.textAlignment = NSTextAlignmentLeft;
    self.rankingPlace.layer.shadowColor = [[UIColor whiteColor] CGColor];
    self.rankingPlace.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.rankingPlace.layer.shadowOpacity = 1.0f;
    self.rankingPlace.layer.shadowRadius = 1.0f;
    [self addSubview:self.rankingPlace];
    
    shadowOverImagesView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"universalselfiepreview_shadow.png"]];
    shadowOverImagesView.contentMode = UIViewContentModeScaleAspectFit;
    CGRect cr = shadowOverImagesView.frame;
    cr.size.width *= 0.5;
    cr.size.height *= 0.5;
    cr.origin.y = self.selfieImageView.frame.size.height + self.selfieImageView.frame.origin.y - cr.size.height;
    shadowOverImagesView.frame = cr;
    [self addSubview:shadowOverImagesView];
    
    
    facebookProfileBackground = [[UIImageView alloc] initWithFrame:CGRectMake(10, 270, 38, 38)];
    facebookProfileBackground.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    facebookProfileBackground.contentMode = UIViewContentModeScaleAspectFit;
    facebookProfileBackground.image = [UIImage imageNamed:@"iphone4_shootbutton"];
    [self addSubview:facebookProfileBackground];
    
    self.facebookProfilePicture = [[UIImageView alloc] initWithFrame:facebookProfileBackground.frame];
    //self.facebookProfilePicture.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    self.facebookProfilePicture.backgroundColor = [UIColor clearColor];
    [self addSubview:self.facebookProfilePicture];
    
    
    self.facebookNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 270, self.frame.size.width - 58, 38)];
    self.facebookNameLabel.text = @"";
    self.facebookNameLabel.backgroundColor = [UIColor clearColor];
    self.facebookNameLabel.textAlignment = NSTextAlignmentLeft;
    self.facebookNameLabel.textColor = [UIColor whiteColor];
    [self.facebookNameLabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:14]];
    [self addSubview:self.facebookNameLabel];
    
    float width = 120;
    //this view sets its own height.
    self.scoreViewForTopImages = [[ScoreViewForTopImages alloc] initWithFrame:CGRectMake(0, self.rankingPlace.frame.origin.y + self.rankingPlace.frame.size.height + 6, width, 0)];
    [self addSubview:self.scoreViewForTopImages];
    
    
    
    
    
    
    
    
    //setting up the extra view.
    
    self.extraView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height + 2, self.frame.size.width, 130)];
    self.extraView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.extraView];
    
    
    float fontsize = 14;
    float MARGIN = 8;
    
    width = 80;
    cr = CGRectMake(self.extraView.frame.size.width - width - MARGIN, MARGIN, width, fontsize + 4);
    
    labelrank = [[UILabel alloc] initWithFrame:cr];
    labelrank.backgroundColor = [UIColor clearColor];
    labelrank.font = [UIFont fontWithName:@"MyriadPro-Bold" size:fontsize];
    labelrank.textColor = [UIColor colorWithWhite:0.5 alpha:1];//[SSMacros colorNormalForVoteType:SSVoteTypeFunny];
    labelrank.text = @"Rank";
    [self.extraView addSubview:labelrank];
    
    cr.origin.x = labelrank.frame.origin.x - width - MARGIN;
    labelvotes = [[UILabel alloc] initWithFrame:cr];
    labelvotes.backgroundColor = [UIColor clearColor];
    labelvotes.font = [UIFont fontWithName:@"MyriadPro-Bold" size:fontsize];
    labelvotes.textColor = [UIColor colorWithWhite:0.5 alpha:1];//[SSMacros colorNormalForVoteType:SSVoteTypeFunny];
    labelvotes.text = @"Votes";
    [self.extraView addSubview:labelvotes];
    
    
    fontsize = 16;
    float MARGINVER = 4;
    float initialpos = labelrank.frame.origin.y + labelrank.frame.size.height + MARGIN;
    UILabel *l;
    
    cr = CGRectMake(MARGIN, initialpos, 100, fontsize +4);
    l = [[UILabel alloc] initWithFrame:cr];
    l.backgroundColor = [UIColor clearColor];
    l.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    l.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeFunny];
    l.text = @"SO funny!";
    [self.extraView addSubview:l];
    
    cr.origin.y = l.frame.origin.y + l.frame.size.height + MARGINVER;
    l = [[UILabel alloc] initWithFrame:cr];
    l.backgroundColor = [UIColor clearColor];
    l.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    l.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeHot];
    l.text = @"SO hot!";
    [self.extraView addSubview:l];
    
    cr.origin.y = l.frame.origin.y + l.frame.size.height + MARGINVER;
    l = [[UILabel alloc] initWithFrame:cr];
    l.backgroundColor = [UIColor clearColor];
    l.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    l.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeLame];
    l.text = @"SO lame!";
    [self.extraView addSubview:l];
    
    cr.origin.y = l.frame.origin.y + l.frame.size.height + MARGINVER;
    l = [[UILabel alloc] initWithFrame:cr];
    l.backgroundColor = [UIColor clearColor];
    l.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    l.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeTryAgain];
    l.text = @"SO weird!";
    [self.extraView addSubview:l];
    
    
    float height = fontsize + 4;
    cr = CGRectMake(labelvotes.frame.origin.x, initialpos, 100, height);
    labelsofunny = [[UILabel alloc] initWithFrame:cr];
    labelsofunny.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    labelsofunny.backgroundColor = [UIColor clearColor];
    labelsofunny.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeFunny];
    //labelsofunny.text = @"#100";
    [self.extraView addSubview:labelsofunny];
    
    cr.origin.y += height + MARGINVER;
    labelsohot = [[UILabel alloc] initWithFrame:cr];
    labelsohot.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    labelsohot.backgroundColor = [UIColor clearColor];
    labelsohot.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeHot];
    //labelsohot.text = @"#100";
    [self.extraView addSubview:labelsohot];
    
    cr.origin.y += height + MARGINVER;
    labelsolame = [[UILabel alloc] initWithFrame:cr];
    labelsolame.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    labelsolame.backgroundColor = [UIColor clearColor];
    labelsolame.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeLame];
    //labelsolame.text = @"#100";
    [self.extraView addSubview:labelsolame];
    
    cr.origin.y += height + MARGINVER;
    labelsoweird = [[UILabel alloc] initWithFrame:cr];
    labelsoweird.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    labelsoweird.backgroundColor = [UIColor clearColor];
    labelsoweird.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeTryAgain];
    //labelsoweird.text = @"#100";
    [self.extraView addSubview:labelsoweird];
    
    cr.origin.x = labelrank.frame.origin.x;
    
    cr.origin.y = initialpos;
    labelranksofunny = [[UILabel alloc] initWithFrame:cr];
    labelranksofunny.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    labelranksofunny.backgroundColor = [UIColor clearColor];
    labelranksofunny.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeFunny];
    //labelranksofunny.text = @"#9001";
    [self.extraView addSubview:labelranksofunny];
    
    cr.origin.y += height + MARGINVER;
    labelranksohot = [[UILabel alloc] initWithFrame:cr];
    labelranksohot.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    labelranksohot.backgroundColor = [UIColor clearColor];
    labelranksohot.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeHot];
    //labelranksohot.text = @"#9001";
    [self.extraView addSubview:labelranksohot];
    
    cr.origin.y += height + MARGINVER;
    labelranksolame = [[UILabel alloc] initWithFrame:cr];
    labelranksolame.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    labelranksolame.backgroundColor = [UIColor clearColor];
    labelranksolame.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeLame];
    //labelranksolame.text = @"#9001";
    [self.extraView addSubview:labelranksolame];
    
    cr.origin.y += height + MARGINVER;
    labelranksoweird = [[UILabel alloc] initWithFrame:cr];
    labelranksoweird.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    labelranksoweird.backgroundColor = [UIColor clearColor];
    labelranksoweird.textColor = [SSMacros colorNormalForVoteType:SSVoteTypeTryAgain];
    //labelranksoweird.text = @"#9001";
    [self.extraView addSubview:labelranksoweird];
    
    
    
    
    [self setScoreViewStatus:NO instant:YES];
   
    return self;
}

- (void) applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    
    /*
    if ([[layoutAttributes class] isEqual: [TopChartCollectionViewLayoutAttributes class]] == false) {
        [super applyLayoutAttributes:layoutAttributes];
        return;
    };
    
    TopChartCollectionViewLayoutAttributes *t = (TopChartCollectionViewLayoutAttributes*)layoutAttributes;
    [[self layer] addAnimation:t.transformAnimation forKey:@"transform"];
    [super applyLayoutAttributes:layoutAttributes];
     */
}


-(void)startWithImageData:(NSDictionary *)imageData {
    
    self.imageData = imageData;
    
    labelsofunny.text = [NSString stringWithFormat:@"%@", imageData[@"votes_funny"][@"count"]];
    labelsohot.text = [NSString stringWithFormat:@"%@", imageData[@"votes_hot"][@"count"]];
    labelsolame.text = [NSString stringWithFormat:@"%@", imageData[@"votes_lame"][@"count"]];
    labelsoweird.text = [NSString stringWithFormat:@"%@", imageData[@"votes_weird"][@"count"]];
    
    //the null check is only with this one because this is the only one that seems to exhibit random crashes.
    if( imageData[@"votes_funny"][@"rank"] != [NSNull null] ) labelranksofunny.text = [NSString stringWithFormat:@"#%@", imageData[@"votes_funny"][@"rank"]];
    labelranksohot.text = [NSString stringWithFormat:@"#%@", imageData[@"votes_hot"][@"rank"]];
    labelranksolame.text = [NSString stringWithFormat:@"#%@", imageData[@"votes_lame"][@"rank"]];
    labelranksoweird.text = [NSString stringWithFormat:@"#%@", imageData[@"votes_weird"][@"rank"]];
    
    [SSAPI getImageWithImageURL:self.imageData[@"url_small"] onComplete:^(UIImage *image, NSError *error){
        if (self.imageData != imageData) return;
        
        self.selfieImageView.image = image;
    }];
    
    [SSAPI getUserFullName:self.imageData[@"user"][@"fbid"] onComplete:^(NSString *fullName, NSError *error){
        if (self.imageData != imageData) return;
        
        self.facebookNameLabel.text = fullName;
    }];
    
    [SSAPI getProfilePictureOfUser:self.imageData[@"user"][@"fbid"] withSize:facebookProfileBackground.frame.size onComplete:^(UIImage *image, NSError *error){
        if (self.imageData != imageData) return;
        
        self.facebookProfilePicture.image = image;
        
    }];
}

-(void)setScoreViewStatus:(BOOL)visible instant:(BOOL)instant {
    float alpha = 0;
    if (visible == YES) alpha = 1;
    
    self.scoreViewIsVisible = visible;
    
    NSTimeInterval duration = instant == true ? 0 : 0.2;
    
    [UIView animateWithDuration:duration animations:^() {
        self.scoreViewForTopImages.alpha = alpha;
    }];
}

-(void)displayScoreViewOnTap {
    
    /*
    scoreViewIsVisible = !scoreViewIsVisible;
    
    float alpha = 0;
    if (scoreViewIsVisible == YES) alpha = 1;
    
    [UIView animateWithDuration:0.2 animations:^() {
        self.scoreViewForTopImages.alpha = alpha;
    }];
    
    return;
    
    CGRect newScoreViewFrame = self.scoreViewForTopImages.frame;
    
    if (scoreViewIsVisible == YES){
        newScoreViewFrame.origin.x = 0;
        scoreViewIsVisible = NO;
    }
    else {
        newScoreViewFrame.origin.x = - 160;
        scoreViewIsVisible = YES;
    }
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.scoreViewForTopImages.frame = newScoreViewFrame; 
                     }
                     completion:nil];
     */
}

-(void)prepareForReuse {
    
    [self setScoreViewStatus:NO instant:YES];
    
    self.open = false;
    self.imageData = nil;
    self.selfieImageView.image = nil;
    self.facebookNameLabel.text = @"";
    self.facebookProfilePicture.image = nil;
    
    labelranksofunny.text = @"";
    labelranksohot.text = @"";
    labelranksolame.text = @"";
    labelranksoweird.text = @"";
    
    labelsofunny.text = @"";
    labelsohot.text = @"";
    labelsolame.text = @"";
    labelsoweird.text = @"";
}


@end
