//
//  SelfiesCollectionViewCell.m
//  SoSelfie
//
//  Created by TYG on 28/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "SelfiesCollectionViewCell.h"
#import "SSAPI.h"

@interface SelfiesCollectionViewCell () {
    
}

@property (weak) NSDictionary *imageData;

@end

@implementation SelfiesCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        float MARGIN = 4;
        float width = self.frame.size.height - 2 * MARGIN;
        self.imageThumbView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, width, width)];
        [self addSubview:self.imageThumbView];
        
        
        //Labels
        
        int textsize = 15;
        int labelheight = 17;
        NSString *myriadBoldFont = @"MyriadPro-Bold";
        
        //soFunnyLine
        
        int y1 = 8;
        
        UILabel *soFunnyLabel = [[UILabel alloc] initWithFrame:CGRectMake(130,y1,100,labelheight)];
        soFunnyLabel.text = @"SO funny!";
        soFunnyLabel.textColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
        soFunnyLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        [self addSubview:soFunnyLabel];
        
        self.soFunnyVotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, y1, 50, labelheight)];
        self.soFunnyVotesLabel.textColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
        self.soFunnyVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soFunnyVotesLabel.text = [NSString stringWithFormat:@"%d",self.soFunnyVotes];
        [self addSubview:self.soFunnyVotesLabel];
        
        self.soFunnyRankLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, y1, 50, labelheight)];
        self.soFunnyRankLabel.textColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
        self.soFunnyRankLabel.font = [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soFunnyRankLabel.text = [NSString stringWithFormat:@"#%d",self.soFunnyRank];
        [self addSubview:self.soFunnyRankLabel];
        
        
        //soHotLine
        
        int y2 = y1 + labelheight;
        
        UILabel *soHotLabel = [[UILabel alloc] initWithFrame:CGRectMake(130,y2,100,labelheight)];
        soHotLabel.text = @"SO hot!";
        soHotLabel.textColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
        soHotLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        [self addSubview:soHotLabel];
        
        self.soHotVotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, y2, 50, labelheight)];
        self.soHotVotesLabel.textColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
        self.soHotVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soHotVotesLabel.text = [NSString stringWithFormat:@"%d",self.soHotVotes];
        [self addSubview:self.soHotVotesLabel];
        
        self.soHotRankLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, y2, 50, labelheight)];
        self.soHotRankLabel.textColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
        self.soHotRankLabel.font = [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soHotRankLabel.text = [NSString stringWithFormat:@"#%d",self.soHotRank];
        [self addSubview:self.soHotRankLabel];
        
        //soLameLine
        
        int y3 = y2 + labelheight;
        
        UILabel *soLameLabel = [[UILabel alloc] initWithFrame:CGRectMake(130,y3,100,labelheight)];
        soLameLabel.text = @"SO lame!";
        soLameLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
        soLameLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        [self addSubview:soLameLabel];
        
        self.soLameVotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, y3, 50, labelheight)];
        self.soLameVotesLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
        self.soLameVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soLameVotesLabel.text = [NSString stringWithFormat:@"%d",self.soLameVotes];
        [self addSubview:self.soLameVotesLabel];
        
        self.soLameRankLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, y3, 50, labelheight)];
        self.soLameRankLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
        self.soLameRankLabel.font = [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.soLameRankLabel.text = [NSString stringWithFormat:@"#%d",self.soLameRank];
        [self addSubview:self.soLameRankLabel];
        
        
        //tryAgainLine
        
        int y4 = y3 + labelheight;
        
        UILabel *tryAgainLabel = [[UILabel alloc] initWithFrame:CGRectMake(130,y4,100,labelheight)];
        tryAgainLabel.text = @"SO weird!";
        tryAgainLabel.textColor =[UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
        tryAgainLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        [self addSubview:tryAgainLabel];
        
        self.tryAgainVotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(235,y4, 50, labelheight)];
        self.tryAgainVotesLabel.textColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
        self.tryAgainVotesLabel.font =  [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.tryAgainVotesLabel.text = [NSString stringWithFormat:@"%d",self.tryAgainVotes];
        [self addSubview:self.tryAgainVotesLabel];
        
        self.tryAgainRankLabel = [[UILabel alloc] initWithFrame:CGRectMake(280,y4, 50, labelheight)];
        self.tryAgainRankLabel.textColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
        self.tryAgainRankLabel.font = [UIFont fontWithName:myriadBoldFont size:textsize];
        //self.tryAgainRankLabel.text = [NSString stringWithFormat:@"#%d",self.soLameRank];
        [self addSubview:self.tryAgainRankLabel];
        
        //border bottom
        
        UIView *bottomBorderLine = [[UIView alloc] initWithFrame: CGRectMake(0,self.frame.size.height - 0.5 ,self.frame.size.width,1)];
        [self addSubview:bottomBorderLine];
        bottomBorderLine.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
        [self addSubview:bottomBorderLine];
        
    
        self.eraseSelfieButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame: CGRectMake(self.frame.size.width - 93 - MARGIN, self.frame.size.height - 32 - MARGIN, 93, 32) withBackgroundColor:[UIColor colorWithRed:(186/255.0) green:(188/255.0) blue:(190/255.0) alpha:1] highlightColor:[UIColor colorWithRed:(207/255.0) green:(208/255.0) blue:(209/255.0) alpha:1] titleLabel:@"Erase Selfie" withFontSize:15];
        [self.eraseSelfieButton addTarget:self action:@selector(eraseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.eraseSelfieButton];
        
        
    }
    return self;
}


-(void)startWithImageData:(NSDictionary *)imageData {
    //NSLog(@"image data %@", imageData[@"id"]);
    
    self.imageData = imageData;
    
    [SSAPI getImageWithImageURL:self.imageData[@"url_small"] onComplete:^(UIImage *image, NSError* error){
        if (self.imageData != imageData) return;
        
        self.imageThumbView.image = image;
        
        NSString *s;
        
        s = self.imageData[@"votes_funny"][@"rank"] == [NSNull null] ? nil : self.imageData[@"votes_funny"][@"rank"];
        if (s) s = [NSString stringWithFormat:@"#%@", s];
        self.soFunnyRankLabel.text = s;
        
        s = self.imageData[@"votes_hot"][@"rank"] == [NSNull null] ? nil : self.imageData[@"votes_hot"][@"rank"];
        if (s) s = [NSString stringWithFormat:@"#%@", s];
        self.soHotRankLabel.text = s;
        
        s = self.imageData[@"votes_lame"][@"rank"] == [NSNull null] ? nil : self.imageData[@"votes_lame"][@"rank"];
        if (s) s = [NSString stringWithFormat:@"#%@", s];
        self.soLameRankLabel.text = s;
        
        s = self.imageData[@"votes_weird"][@"rank"] == [NSNull null] ? nil : self.imageData[@"votes_weird"][@"rank"];
        if (s) s = [NSString stringWithFormat:@"#%@", s];
        self.tryAgainRankLabel.text = s;
        
        
        self.soFunnyVotesLabel.text = self.imageData[@"votes_funny"][@"count"];
        self.soHotVotesLabel.text = self.imageData[@"votes_hot"][@"count"];
        self.soLameVotesLabel.text = self.imageData[@"votes_lame"][@"count"];
        self.tryAgainVotesLabel.text = self.imageData[@"votes_weird"][@"count"];
    }];
    
}

-(void)eraseButtonClicked:(id)sender {
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Erase Selfie?" message:@"Are you sure you wanna erase this Selfie?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [v show];
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) return;
    
    [self.delegate selfiesCollectionViewCell:self pressedDeleteWithImageData:self.imageData];
}

-(void)prepareForReuse {
    self.imageThumbView.image = nil;
    
    self.soFunnyVotesLabel.text = @"";
    self.soHotVotesLabel.text = @"";
    self.soLameVotesLabel.text = @"";
    self.tryAgainVotesLabel.text = @"";
    
    self.soFunnyRankLabel.text = @"";
    self.soHotRankLabel.text = @"";
    self.soLameRankLabel.text = @"";
    self.tryAgainRankLabel.text = @"";
}



@end
