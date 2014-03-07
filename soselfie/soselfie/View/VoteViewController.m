//
//  VoteViewController.m
//  SoSelfie
//
//  Created by TYG on 26/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "VoteViewController.h"
#import "VoteCollectionViewFlowLayout.h"
#import "SSAPI.h"

@interface VoteViewController () {
    //long selfieCellCounter;
    int collectioncellcounter;
    BOOL firstView;
    
    NSArray *excludeIDs;
    
}

@end

@implementation VoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    firstView = true;
    collectioncellcounter = 1;
    
    VoteCollectionViewFlowLayout *layout = [[VoteCollectionViewFlowLayout alloc] init];
    //[layout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.mainVoteCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake
                                   (0, 60, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    self.mainVoteCollectionView.delegate = self;
    self.mainVoteCollectionView.dataSource = self;
    [self.mainVoteCollectionView registerClass:[VoteCollectionViewCell class] forCellWithReuseIdentifier:@"MyCell"];
    self.mainVoteCollectionView.pagingEnabled = NO;
    self.mainVoteCollectionView.scrollEnabled = NO;
    [self.view addSubview:self.mainVoteCollectionView];
    
    
    
    //setting up the tabbarview
    self.tabBarView = [[TabBarView alloc] init];
    self.tabBarView.frame = CGRectMake(0, 0, 320, 60);
    self.tabBarView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
    self.tabBarView.headerLabel.text = @"vote";
    self.tabBarView.shootButton.hidden = NO;
    [self.view addSubview:self.tabBarView];
    [self.view bringSubviewToFront:self.tabBarView];
    
    
    return self;
}


-(void)becameVisible {
    if (firstView == true) [self.mainVoteCollectionView reloadData];
    firstView = false;
}
-(void)userloggedout {    
    firstView = true;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return collectioncellcounter;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    

    VoteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    cell.delegate = self;
    //this class is created at the start of everything, and then moved into view / out of view, so the first time this function is called, you are probably not logged in and then the getRandomImage will throw an error. To prevent this, we check for an existing fbid.
    
    if ([SSAPI fbid] != nil) [cell getRandomImage];
    
    return cell;
    
}

static CGSize indexSize;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexSize.width == 0 || indexSize.height == 0) indexSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    return indexSize;
}
-(void)voteCollectionViewCellDoneVoting:(VoteCollectionViewCell *)cell {
    collectioncellcounter = 2;
    
    [self.mainVoteCollectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:1 inSection:0]]];
    
    [UIView animateWithDuration:0.25 delay:0 options:0 animations:^() {
        //this is -1 because if it's exactly the length of the other cell, the collectionview will already remove the cell's content (it will treat it as invisible), even though it is still visibly being animated.
        self.mainVoteCollectionView.contentOffset = CGPointMake(self.view.frame.size.width - 1, 0);
    } completion:^(BOOL finished) {
        collectioncellcounter = 1;
        self.mainVoteCollectionView.contentOffset = CGPointMake(0, 0);
        [self.mainVoteCollectionView reloadData];
    }];
    
    
}


@end
