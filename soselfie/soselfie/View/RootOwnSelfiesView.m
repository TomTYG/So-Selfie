//
//  RootOwnSelfiesView.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 25/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "RootOwnSelfiesView.h"
#import "RootOwnSelfiesViewCell.h"
#import "SSAPI.h"

@interface RootOwnSelfiesView () {
    UICollectionView *collectionview;
    NSArray *collectionData;
    
    BOOL alreadyRefreshing;
    int total;
}

@end

@implementation RootOwnSelfiesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    alreadyRefreshing = false;
    total = 0;
    collectionData = @[];
    
    UICollectionViewFlowLayout *f = [[UICollectionViewFlowLayout alloc] init];
    f.scrollDirection = UICollectionViewScrollDirectionVertical;
    f.minimumInteritemSpacing = 12;
    
    collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:f];
    collectionview.delegate = self;
    collectionview.dataSource = self;
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    collectionview.backgroundColor = [UIColor clearColor];
    [collectionview registerClass:[RootOwnSelfiesViewCell class] forCellWithReuseIdentifier:@"rootownselfiesviewcell"];
    [self addSubview:collectionview];
    
    
    
    return self;
}


-(void)refreshData {
    
    total = 0;
    [SSAPI getOwnSelfiesStartingFromIndex:0 onComplete:^(int totalSelfies, NSArray *images, NSError *error) {
        if (error != nil) {
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:error.domain message:error.userInfo[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [v show];
            return;
        }
        
        collectionData = images;
        [collectionview setContentOffset:CGPointMake(collectionview.contentOffset.x, 0) animated:NO];
        [collectionview reloadData];
        
        total = totalSelfies;
        //NSLog(@"get own selfie %i %@", totalSelfies, images);
    }];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (alreadyRefreshing == true) return;
    if (scrollView.contentOffset.y < scrollView.contentSize.height - scrollView.frame.size.height) return;
    
    int index = (int)collectionData.count;
    if (total <= index) return;
    
    //NSLog(@"refreshing scrollview %i %i", index ,total);
    
    alreadyRefreshing = true;
    [SSAPI getOwnSelfiesStartingFromIndex:index onComplete:^(int totalSelfies, NSArray *images, NSError *error){
        if (error != nil) {
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:error.domain message:error.userInfo[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [v show];
            return;
        }
        
        alreadyRefreshing = false;
        
        NSMutableArray *a = [collectionData mutableCopy];
        [a addObjectsFromArray:images];
        collectionData = a;
        [collectionview reloadData];
        
        total = totalSelfies;
        
    }];
}


static CGSize itemSize;

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (itemSize.width == 0 || itemSize.height == 0) itemSize = CGSizeMake(320, 162);
    
    return itemSize;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionData.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RootOwnSelfiesViewCell *r = [collectionview dequeueReusableCellWithReuseIdentifier:@"rootownselfiesviewcell" forIndexPath:indexPath];
    r.delegate = self;
    [r startWithData:collectionData[indexPath.item]];
    
    return r;
}


-(void)viewCellClickedEraseButton:(RootOwnSelfiesViewCell *)cell {
    NSString *imageid = cell.data[@"id"];
    
    int index = -1;
    for (int i = 0; i < collectionData.count; i++ ) {
        if ([collectionData[i][@"id"] isEqualToString:imageid]) {
            index = i;
            break;
        }
    }
    if (index == -1) return;
    NSLog(@"clicked erase %@ %i", imageid, index);
    
    NSMutableArray *a = [collectionData mutableCopy];
    [a removeObjectAtIndex:index];
    collectionData = a;
    
    [collectionview deleteItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:index inSection:0]]];
    
    total--;
    
}


@end
