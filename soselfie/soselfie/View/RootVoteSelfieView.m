//
//  RootVoteSelfieView.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 28/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "RootVoteSelfieView.h"
#import <FacebookSDK/FacebookSDK.h>


@interface RootVoteSelfieView () {
    UIImageView *imageview;
    UIButton *buttonfunny;
    UIButton *buttonhot;
    UIButton *buttonlame;
    UIButton *buttontryagain;
    
    NSString *currentSelfieID;
    NSString *currentSelfieURL;
    NSString *currentSelfieURLsmall;
    NSString *currentSelfieAccessToken;
    NSDictionary *currentSelfieVotes;
    NSString *currentSelfieFBID;
    
    int totalvotescast;
}

@end

@implementation RootVoteSelfieView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    //self.backgroundColor = [UIColor lightGrayColor];
    self.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:161.0/255.0 blue:245.0/255.0 alpha:1];
    imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    imageview.backgroundColor = [UIColor clearColor];
    [self addSubview:imageview];
    
    float MARGIN = 6;
    float height = imageview.frame.origin.y + imageview.frame.size.height + MARGIN;
    
    buttonfunny = [[UIButton alloc] initWithFrame:CGRectMake(0, height, self.frame.size.width, 40)];
    [buttonfunny setTitle:@"So Funny" forState:UIControlStateNormal];
    [buttonfunny setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonfunny setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [buttonfunny addTarget:self action:@selector(buttonfunnyclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonfunny];
    
    height = buttonfunny.frame.origin.y + buttonfunny.frame.size.height + MARGIN;
    
    buttonhot = [[UIButton alloc] initWithFrame:CGRectMake(0, height, self.frame.size.width, 40)];
    [buttonhot setTitle:@"So Hot" forState:UIControlStateNormal];
    [buttonhot setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonhot setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [buttonhot addTarget:self action:@selector(buttonhotclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonhot];
    
    height = buttonhot.frame.origin.y + buttonhot.frame.size.height + MARGIN;
    
    buttonlame = [[UIButton alloc] initWithFrame:CGRectMake(0, height, self.frame.size.width, 40)];
    [buttonlame setTitle:@"So Lame" forState:UIControlStateNormal];
    [buttonlame setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonlame setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [buttonlame addTarget:self action:@selector(buttonlameclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonlame];
    
    height = buttonlame.frame.origin.y + buttonlame.frame.size.height + MARGIN;
    
    buttontryagain = [[UIButton alloc] initWithFrame:CGRectMake(0, height, self.frame.size.width, 40)];
    [buttontryagain setTitle:@"Try again" forState:UIControlStateNormal];
    [buttontryagain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttontryagain setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [buttontryagain addTarget:self action:@selector(buttontryagainclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttontryagain];
    
    CGRect c = self.frame;
    c.size.height = buttontryagain.frame.origin.y + buttontryagain.frame.size.height + MARGIN;
    self.frame = c;
    
    
    return self;
}

-(void)getRandomSelfie {
    SSUserGender genders = [self.delegate voteSelfieViewNeedsGenders:self];
    int min = [self.delegate voteSelfieViewNeedsMinimumAge:self];
    int max = [self.delegate voteSelfieViewNeedsMaximumAge:self];
    
    [SSAPI getRandomSelfieForMinimumAge:min andMaximumAge:max andGenders:genders onComplete:^(NSString *selfieID, NSString *ownerfbid, NSString *imageURL, NSString *imageURLsmall, NSString *imageAccessToken, NSDictionary *votes, NSError *error) {
        
        totalvotescast++;
        
        if (error != nil) {
            imageview.image = nil;
            if (totalvotescast <= 1) return; //not 0, because totalvotescast is already implemented by 1 above.
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:error.domain message:error.userInfo[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [v show];
            return;
        }
        
        currentSelfieID = selfieID;
        currentSelfieFBID = ownerfbid;
        currentSelfieURL = imageURL;
        currentSelfieURLsmall = imageURLsmall;
        currentSelfieVotes = votes;
        currentSelfieAccessToken = imageAccessToken;
        
        [SSAPI getImageWithImageURL:currentSelfieURLsmall onComplete:^(UIImage *image, NSError* error) {
            if (currentSelfieURLsmall != imageURLsmall) return;
            if (error != nil) return;
            imageview.image = image;
        }];
        
        //NSLog(@"random selfie %@ %@ %@ %@ %@ %@ %@", selfieID, ownerfbid, imageURL, imageURLsmall, imageAccessToken, votes, error);
        
    }];
}


-(void)buttonfunnyclicked:(id)sender {
    [self voteOnCurrentPictureWithVote:SSVoteTypeFunny];
}
-(void)buttonhotclicked:(id)sender {
    [self voteOnCurrentPictureWithVote:SSVoteTypeHot];
}
-(void)buttonlameclicked:(id)sender {
    [self voteOnCurrentPictureWithVote:SSVoteTypeLame];
}
-(void)buttontryagainclicked:(id)sender {
    [self voteOnCurrentPictureWithVote:SSVoteTypeTryAgain];
}

-(void)voteOnCurrentPictureWithVote:(SSVoteType)vote {
    
    
    if (currentSelfieID == nil) {
        [self getRandomSelfie];
        return;
    }
    
    [SSAPI voteForSelfieID:currentSelfieID andImageAccessToken:currentSelfieAccessToken andVote:vote onComplete:^(BOOL success, NSError *possibleError){
        
        NSLog(@"sent vote %@ %@", @(success), possibleError);
        
        if (possibleError != nil) {
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:possibleError.domain message:possibleError.userInfo[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [v show];
            return;
        }
        
        [self getRandomSelfie];
    }];
    
    currentSelfieID = nil;
    
}

@end
