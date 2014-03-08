//
//  TopChartCollectionViewCell.m
//  SoSelfie
//
//  Created by TYG on 03/03/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "TopChartCollectionViewCell.h"
#import "SSAPI.h"

@interface TopChartCollectionViewCell () {
    
    
    UIImageView *facebookProfileBackground;
    UIImageView *shadowOverImagesView;
    
}

@property (weak) NSDictionary *imageData;

@end

@implementation TopChartCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
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
    
    /*
    UIView *containerViewForScoreView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - width, 0, width, 0)];
    containerViewForScoreView.backgroundColor = [UIColor clearColor];
    [self addSubview:containerViewForScoreView];
    
    containerViewForScoreView.clipsToBounds = YES;
    */
    
    [self setScoreViewStatus:NO instant:YES];
   
    return self;
}

-(void)startWithImageData:(NSDictionary *)imageData {
    
    self.imageData = imageData;
    
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
    
    self.imageData = nil;
    self.selfieImageView.image = nil;
    self.facebookNameLabel.text = @"";
    self.facebookProfilePicture.image = nil;
}


@end
