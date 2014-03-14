//
//  VoteViewController.m
//  SoSelfie
//
//  Created by TYG on 26/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "VoteViewController.h"
#import "SSAPI.h"
#import "SSMacros.h"
#import "SSLoadingView.h"

@interface VoteViewController () {
    //BOOL firstView;
    
    NSArray *currentImageDatas;
    NSArray *votesNotDoneArray;
    
    UIView *novotesview;
    UIImageView *badsmileyview;
    GenericSoSelfieButtonWithOptionalSubtitle *refreshSelfiesButton;
    GenericSoSelfieButtonWithOptionalSubtitle *shootSelfiesButton;
    
    UIView *loadingView;
    UILabel *gettingNewSelfies;
    
    UIScrollView *votecontainer;
    NSMutableArray *voteviews;
}

@end

@implementation VoteViewController


-(void)start {
    
    
    self.view.backgroundColor = [SSMacros colorNormalForVoteType:SSVoteTypeHot];
    
    //setting up the tabbarview
    self.tabBarView = [[TabBarView alloc] init];
    self.tabBarView.headerLabel.text = @"Vote!";
    self.tabBarView.shootButton.hidden = NO;
    [self.view addSubview:self.tabBarView];
    
    
    
    
    
    
    
    
    novotesview = [[UIView alloc] initWithFrame:self.view.bounds];
    novotesview.backgroundColor = [UIColor clearColor];
    novotesview.alpha = 0;
    [self.view addSubview:novotesview];
    badsmileyview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"errorFACE"]];
    CGRect cr = badsmileyview.frame;
    cr.size.width *= 0.5;
    cr.size.height *= 0.5;
    cr.origin.x = 0.5 * novotesview.frame.size.width - 0.5 * cr.size.width;
    cr.origin.y = 0.5 * novotesview.frame.size.height - 0.5 * cr.size.width - 60;
    badsmileyview.frame = cr;
    [novotesview addSubview:badsmileyview];
    
    float width = 250;
    float fontsize = 17;
    UILabel *novoteslabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5 * novotesview.frame.size.width - 0.5 * width, cr.origin.y + cr.size.height + 24, width, (fontsize + 4) * 4)];
    novoteslabel.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    novoteslabel.text = @"Mweeh! No more Selfies.. \nCheck back later for new ones! \n\nFor now:";
    novoteslabel.numberOfLines = 4;
    novoteslabel.backgroundColor = [UIColor clearColor];
    novoteslabel.textColor = [UIColor whiteColor];
    novoteslabel.textAlignment = NSTextAlignmentCenter;
    [novotesview addSubview:novoteslabel];
    
    width = 150;
    float height = 40;
    fontsize = 18;
    
    shootSelfiesButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(0.5 * novotesview.frame.size.width - 0.5 * width, novoteslabel.frame.origin.y + novoteslabel.frame.size.height + 18, width, height) withBackgroundColor:[SSMacros colorNormalForVoteType:SSVoteTypeFunny] highlightColor:[SSMacros colorHighlightedForVoteType:SSVoteTypeFunny] titleLabel:@"SHOOT ONE!" withFontSize:fontsize];
    shootSelfiesButton.titleLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    [shootSelfiesButton addTarget:self action:@selector(shootSelfieButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [novotesview addSubview:shootSelfiesButton];
    
    refreshSelfiesButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(shootSelfiesButton.frame.origin.x, shootSelfiesButton.frame.origin.y + shootSelfiesButton.frame.size.height + 18, width, height) withBackgroundColor:[SSMacros colorNormalForVoteType:SSVoteTypeFunny] highlightColor:[SSMacros colorHighlightedForVoteType:SSVoteTypeFunny] titleLabel:@"REFRESH" withFontSize:fontsize];
    refreshSelfiesButton.titleLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:fontsize];
    [refreshSelfiesButton addTarget:self action:@selector(refreshSelfieButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [novotesview addSubview:refreshSelfiesButton];
    
    loadingView = [[UIView alloc] initWithFrame:novotesview.bounds];
    loadingView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:loadingView];
    loadingView.alpha = 0;
    SSLoadingView *s = [[SSLoadingView alloc] initWithFrame:CGRectZero];
    cr = s.frame;
    cr.origin.x = 0.5 * loadingView.frame.size.width - 0.5 * cr.size.width;
    cr.origin.y = 0.5 * loadingView.frame.size.height - 0.5 * cr.size.height;
    s.frame = cr;
    [loadingView addSubview:s];
    
    
    height = self.tabBarView.frame.size.height + self.tabBarView.frame.origin.y;
    
    votecontainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0, height, self.view.frame.size.width, self.view.frame.size.height - height)];
    votecontainer.backgroundColor = [UIColor clearColor];
    votecontainer.delegate = self;
    votecontainer.clipsToBounds = YES;
    votecontainer.showsHorizontalScrollIndicator = NO;
    votecontainer.scrollEnabled = NO;
    [self.view addSubview:votecontainer];
    
    voteviews = [[NSMutableArray alloc] init];
    
    
    
    
    
    [self.tabBarView.superview bringSubviewToFront:self.tabBarView];
    
    
    currentImageDatas = @[];
    votesNotDoneArray = @[];
}


-(void)becameVisible {
    
    [self addACell];
}
-(void)userloggedout {    
    //firstView = true;
}

-(void)ageOrGenderChanged {
    
    [self removeAllCellsExceptTheFirstOne];
    
}

-(void)addACell {
    
    
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (int i = 0; i < currentImageDatas.count; i++) {
        [a addObject:currentImageDatas[i][@"id"]];
    }
    for (int i = 0; i < votesNotDoneArray.count; i++) {
        [a addObject:votesNotDoneArray[i]];
    }
    
    loadingView.alpha = 1;
    novotesview.alpha = 0;
    
    
    [SSAPI getRandomSelfieForMinimumAge:[SSAPI agemin] andMaximumAge:[SSAPI agemax] andGenders:[SSAPI genders] excludeIDs:a onComplete:^(NSDictionary* imageData, NSError *error){
        
        loadingView.alpha = 0;
        
        if (error != nil) {
            if ([error.domain isEqualToString:@"No more images"]) {
                
                if (currentImageDatas.count == 0) {
                    
                    votecontainer.alpha = 0;
                    [UIView animateWithDuration:0.2 delay:0.1 options:0 animations:^(){
                        novotesview.alpha = 1;
                    } completion:nil];
                }
                
            }
            return;
        }
        
        
        [UIView animateWithDuration:0.1 animations:^() {
            novotesview.alpha = 0;
            votecontainer.alpha = 1;
        }];
        
        for (int i = 0; i < currentImageDatas.count; i++) {
            NSString *s = currentImageDatas[i][@"id"];
            if ([s isEqualToString:imageData[@"id"]]) {
                return;
            }
        }
        currentImageDatas = [currentImageDatas arrayByAddingObject:imageData];
        
        float x = voteviews.count * self.view.frame.size.width;
        
        VoteViewSingle *v = [[VoteViewSingle alloc] initWithFrame:CGRectMake(x, 0, votecontainer.frame.size.width, votecontainer.frame.size.height)];
        NSLog(@"newframe %@", NSStringFromCGRect(v.frame));
        [v startWithImageData:imageData];
        v.delegate = self;
        [voteviews addObject:v];
        [votecontainer addSubview:v];
        
        
        votecontainer.contentSize = CGSizeMake(x + v.frame.size.width, votecontainer.contentSize.height);
        
        
        if (currentImageDatas.count < 3) [self addACell];
        
    }];
}

-(void)removeAllCellsExceptTheFirstOne {
    
    if (currentImageDatas.count == 0) [self becameVisible];
    if (currentImageDatas.count <= 1) return;
    
    //note the i = 1 initial condition.
    for (int i = 1; i < voteviews.count; i++) {
        UIView *v = voteviews[i];
        [v removeFromSuperview];
        [voteviews removeObjectAtIndex:i];
        i--;
    }
    
    currentImageDatas = [NSArray arrayWithObject:currentImageDatas[0]];
    
}



-(void)voteViewSingle:(VoteViewSingle *)voteview clickedVote:(SSVoteType)voteType {
    
    
    NSDictionary *imageData = currentImageDatas[0];
    NSString *imageid = imageData[@"id"];
    
    
    //NSLog(@"voted %@ %i", imageid, voteType);
    
    votesNotDoneArray = [votesNotDoneArray arrayByAddingObject:imageid];
    NSMutableArray *a = [currentImageDatas mutableCopy];
    [a removeObjectAtIndex:0];
    currentImageDatas = a;
    
    
    [UIView animateWithDuration:0.3 animations:^() {
        for (int i = 0; i < voteviews.count; i++) {
            UIView *v = voteviews[i];
            CGRect cr = v.frame;
            cr.origin.x -= votecontainer.frame.size.width;
            
            v.frame = cr;
        }
    } completion:^(BOOL finished) {
        for (int i = 0; i < voteviews.count; i++) {
            UIView *v = voteviews[i];
            if (v.frame.origin.x >= 0) continue;
            
            [v removeFromSuperview];
            [voteviews removeObjectAtIndex:i];
            i--;
        }
    }];
    
    [SSAPI voteForSelfieID:imageid andImageAccessToken:imageData[@"accesstoken"] andVote:voteType onComplete:^(BOOL success, NSError *possibleError){
        
        NSMutableArray *a = [votesNotDoneArray mutableCopy];
        for (int i = 0; i < votesNotDoneArray.count; i++) {
            
            NSString *s = votesNotDoneArray[i];
            if ([s isEqualToString:imageid] == true) {
                
                [a removeObjectAtIndex:i];
            }
        }
        votesNotDoneArray = a;
        //NSLog(@"vote complete %@ %i", imageid, vote);
        [self addACell];
        
        
        
    }];
    
    
    
}



-(void)refreshSelfieButtonClicked:(id)sender {
    [self becameVisible];
}
-(void)shootSelfieButtonClicked:(id)sender {
    [self.delegate voteViewControllerClickedShootButton:self];
}




@end
