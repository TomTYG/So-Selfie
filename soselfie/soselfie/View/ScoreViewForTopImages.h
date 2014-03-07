//
//  ScoreViewForTopImages.h
//  soselfie
//
//  Created by TYG on 07/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreViewForTopImages : UIView

//soFunny
@property (strong, nonatomic) UILabel *soFunnyVotesLabel;
@property (strong, nonatomic) UILabel *soFunnyRankLabel;

@property int soFunnyVotes;
@property int soFunnyRank;

//soHot
@property (strong, nonatomic) UILabel *soHotVotesLabel;
@property (strong, nonatomic) UILabel *soHotRankLabel;

@property int soHotVotes;
@property int soHotRank;

//soLame
@property (strong, nonatomic) UILabel *soLameVotesLabel;
@property (strong, nonatomic) UILabel *soLameRankLabel;

@property int soLameVotes;
@property int soLameRank;

//tryAgain
@property (strong, nonatomic) UILabel *tryAgainVotesLabel;
@property (strong, nonatomic) UILabel *tryAgainRankLabel;

@property int tryAgainVotes;
@property int tryAgainRank;

@property BOOL scoreViewIsVisible;

@end
