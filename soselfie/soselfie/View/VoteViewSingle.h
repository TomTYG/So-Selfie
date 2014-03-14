//
//  VoteViewSingle.h
//  soselfie
//
//  Created by Tom van Kruijsbergen on 11/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoteButtonView.h"
#import "SSAPI.h"

@class VoteViewSingle;

@protocol VoteViewSingleDelegate <NSObject>

@required
-(void)voteViewSingle:(VoteViewSingle*)voteview clickedVote:(SSVoteType)voteType;

@end


@interface VoteViewSingle : UIView <VoteButtonViewDelegate, UIAlertViewDelegate>

@property (weak) id<VoteViewSingleDelegate> delegate;
-(void)startWithImageData:(NSDictionary*)imageData;

@end
