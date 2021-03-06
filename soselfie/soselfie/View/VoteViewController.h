//
//  VoteViewController.h
//  SoSelfie
//
//  Created by TYG on 26/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingButtonsViewController.h"
#import "TabBarView.h"
#import "VoteViewSingle.h"


@class VoteViewController;

@protocol VoteViewControllerDelegate <NSObject>

@required
-(void)voteViewControllerClickedShootButton:(VoteViewController*)viewcontroller;

@end


@interface VoteViewController : UIViewController < UIScrollViewDelegate, VoteViewSingleDelegate>

@property (weak) id<VoteViewControllerDelegate>delegate;


@property (strong, nonatomic) TabBarView *tabBarView;

//this method is called by the MasterViewController when it becomes visible. Since viewcontrollers are always on, this is a good way of checking what should happen when a view controller becomes visible.
-(void)becameVisible;
//this method is called by the MasterViewController when the user logs out or erases his account.
-(void)userloggedout;

//this method is called whenever either change. This can potentially be called very often very quickly (if a user is sliding the age slider or spamming the buttons for example), so don't do too heavy calculations here.
-(void)ageOrGenderChanged;

-(void)start;

@end
