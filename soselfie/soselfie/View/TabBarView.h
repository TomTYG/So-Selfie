//
//  TabBarView.h
//  ARSSReader
//
//  Created by TYG on 12/12/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenu.h"
#import "SSMacros.h"
#import "GenericSoSelfieButtonWithOptionalSubtitle.h"
#import "SSDropDownView.h"
#import "SSAPI.h"



@interface TabBarView : UIView <SSDropDownViewDelegate>

@property (strong,nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) GenericSoSelfieButtonWithOptionalSubtitle *filterButton;
@property (strong, nonatomic) UIButton *mainMenuButton;
@property (strong ,nonatomic) UIButton *shootButton;
@property (strong, nonatomic) UIButton *voteButton;

@property SSDropDownView *dropDownViewDateType;
@property SSDropDownView *dropDownViewVoteType;
//@property (strong, nonatomic) DropDownMenu *dropDownMenu;

-(void)closeAllDropDownMenus;

@end
