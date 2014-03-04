//
//  RootVoteSelfieView.h
//  soselfie
//
//  Created by Tom van Kruijsbergen on 28/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSAPI.h"

@class RootVoteSelfieView;

@protocol RootVoteSelfieViewDelegate <NSObject>

@required
-(int)voteSelfieViewNeedsGenders:(RootVoteSelfieView*)voteSelfieView;
-(int)voteSelfieViewNeedsMinimumAge:(RootVoteSelfieView*)voteSelfieView;
-(int)voteSelfieViewNeedsMaximumAge:(RootVoteSelfieView*)voteSelfieView;

@end

@interface RootVoteSelfieView : UIView

@property (weak) id<RootVoteSelfieViewDelegate>delegate;

-(void)getRandomSelfie;
@end
