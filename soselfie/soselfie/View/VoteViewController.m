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
    BOOL firstView;
    
    NSArray *currentImageDatas;
    
}

@end

@implementation VoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    firstView = true;
    
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
    //self.mainVoteCollectionView.pagingEnabled = NO;
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
    
    currentImageDatas = @[];
    
    return self;
}


-(void)becameVisible {
    if (firstView == true) [self.mainVoteCollectionView reloadData];
    firstView = false;
    
    [self addACell];
}
-(void)userloggedout {    
    firstView = true;
}

-(void)ageOrGenderChanged {
    if (currentImageDatas.count <= 1) return;
    
    
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (int i = 1; i < currentImageDatas.count; i++) {
        NSIndexPath *p = [NSIndexPath indexPathForItem:i inSection:0];
        [a addObject:p];
    }
    
    currentImageDatas = [NSArray arrayWithObject:currentImageDatas[0]];
    
    [self.mainVoteCollectionView deleteItemsAtIndexPaths:a];
}

-(void)addACell {
    
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (int i = 0; i < currentImageDatas.count; i++) {
        [a addObject:currentImageDatas[i][@"id"]];
    }
    
    [SSAPI getRandomSelfieForMinimumAge:[SSAPI agemin] andMaximumAge:[SSAPI agemax] andGenders:[SSAPI genders] excludeIDs:a onComplete:^(NSDictionary* imageData, NSError *error){
        
        if (error != nil) {
            if ([error.domain isEqualToString:@"No more images"]) {
                //todo: spawn a "no images screen";
                NSLog(@"no more images!");
            }
            return;
        }
        
        currentImageDatas = [currentImageDatas arrayByAddingObject:imageData];
        
        [self.mainVoteCollectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:currentImageDatas.count - 1 inSection:0]]];
        
        if (currentImageDatas.count < 3) [self addACell];
        
    }];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return currentImageDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    VoteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell startWithImageData:currentImageDatas[indexPath.item]];
    //this class is created at the start of everything, and then moved into view / out of view, so the first time this function is called, you are probably not logged in and then the getRandomImage will throw an error. To prevent this, we check for an existing fbid.
    
    
    //if ([SSAPI fbid] != nil) [cell getRandomImage];
    
    return cell;
    
}

static CGSize indexSize;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexSize.width == 0 || indexSize.height == 0) indexSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    return indexSize;
}

-(void)voteCollectionViewCell:(VoteCollectionViewCell *)cell clickedVote:(SSVoteType)vote {
    
    
    [SSAPI voteForSelfieID:currentImageDatas[0][@"id"] andImageAccessToken:currentImageDatas[0][@"accesstoken"] andVote:vote onComplete:^(BOOL success, NSError *possibleError){
        
        NSLog(@"vote complete %i", vote);
        
    }];
    
    
    
    
    float offset = 0;
    [UIView animateWithDuration:0.5 animations:^() {
        
        self.mainVoteCollectionView.contentOffset = CGPointMake(offset + indexSize.width - 1, self.mainVoteCollectionView.contentOffset.y);
        
    } completion:^(BOOL finished){
        
        NSMutableArray *a = [currentImageDatas mutableCopy];
        [a removeObjectAtIndex:0];
        currentImageDatas = a;
        
        self.mainVoteCollectionView.contentOffset = CGPointMake(0, self.mainVoteCollectionView.contentOffset.y);
        [self.mainVoteCollectionView reloadData];
        /*
        [self.mainVoteCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
        [self.mainVoteCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
         */
    }];
    /*
    [self.mainVoteCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
    */
    
    [self addACell];
    
    
}

-(void)voteCollectionViewCellDoneVoting:(VoteCollectionViewCell *)cell {
    
    
    
    /*
    [self.mainVoteCollectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:1 inSection:0]]];
    
    
    [UIView animateWithDuration:0.25 delay:0 options:0 animations:^() {
        //this is -1 because if it's exactly the length of the other cell, the collectionview will already remove the cell's content (it will treat it as invisible), even though it is still visibly being animated.
        self.mainVoteCollectionView.contentOffset = CGPointMake(self.view.frame.size.width - 1, 0);
    } completion:^(BOOL finished) {
        //collectioncellcounter = 1;
        self.mainVoteCollectionView.contentOffset = CGPointMake(0, 0);
        [self.mainVoteCollectionView reloadData];
    }];
    */
    
}


@end
