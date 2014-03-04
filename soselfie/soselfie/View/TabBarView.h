//
//  TabBarView.h
//  ARSSReader
//
//  Created by TYG on 12/12/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenu.h"

@interface TabBarView : UIView

@property (strong,nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) UIButton *filterButton;
@property (strong, nonatomic) UIButton *mainMenuButton;
@property (strong ,nonatomic) UIButton *shootButton;
@property (strong, nonatomic) UIButton *voteButton;
@property (strong, nonatomic) DropDownMenu *dropDownMenu;

@end
