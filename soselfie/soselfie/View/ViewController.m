//
//  ViewController.m
//  SoSelfie
//
//  Created by TYG on 17/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "ViewController.h"
#import "SSAPI.h"
#import "TopChartCollectionViewFlowLayout.h"
#import "SSLoadingView.h"

#define CELLWIDTH 320

@interface ViewController () {
    NSArray *imageDatas;
    SSVoteType currentVoteType;
    SSDateType currentDateType;
    int previoustotalloading;
    int currentindex;
    RatingButtonsViewController *ratingButtonsViewController;
    UIView *containerViewForRatingButtonsController;
    
    SSLoadingView *loadingView;
    
    NSMutableArray *cellSizes;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentDateType = SSDateTypeAll;
    currentVoteType = SSVoteTypeFunny;
    
    //setting up tabBarView
    self.tabBarView = [[TabBarView alloc] init];
    self.tabBarView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
    self.tabBarView.headerLabel.hidden = YES;
    self.tabBarView.dropDownViewDateType.hidden = NO;
    self.tabBarView.dropDownViewDateType.delegate = self;
    self.tabBarView.dropDownViewVoteType.hidden = NO;
    self.tabBarView.dropDownViewVoteType.delegate = self;
    [self.view addSubview:self.tabBarView];
    
    //setting up collectionView
    TopChartCollectionViewFlowLayout *layout = [[TopChartCollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    float height = self.tabBarView.frame.origin.y + self.tabBarView.frame.size.height;
    self.topChartCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, height, self.view.frame.size.width, self.view.frame.size.height - height) collectionViewLayout:layout];
    self.topChartCollectionView.backgroundColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
    [self.topChartCollectionView setShowsVerticalScrollIndicator:NO];
    self.topChartCollectionView.dataSource = self;
    self.topChartCollectionView.delegate = self;
    [self.topChartCollectionView registerClass:[TopChartCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.view addSubview:self.topChartCollectionView];
    
    
    //setting dropdown menu
    /*
    self.dropDownMenu = [[DropDownMenu alloc] init];
    self.dropDownMenu.view.backgroundColor = [UIColor clearColor];
    self.dropDownMenu.view.frame = CGRectMake (180,-150,140,200);
    self.dropDownMenu.view.alpha = 1.0;
    self.dropDownMenu.tableView.delegate = self;
    [self.view addSubview:self.dropDownMenu.view];
    */
    
    
    
    
    
    imageDatas = @[];
    
    loadingView = [[SSLoadingView alloc] initWithFrame:CGRectZero];
    loadingView.alpha = 0;
    CGRect cr = loadingView.frame;
    cr.origin.x = self.topChartCollectionView.frame.origin.x + 0.5 * self.topChartCollectionView.frame.size.width - 0.5 * cr.size.width;
    cr.origin.y = self.topChartCollectionView.frame.origin.y + 0.5 * self.topChartCollectionView.frame.size.height - 0.5 * cr.size.height;
    loadingView.frame = cr;
    [self.view addSubview:loadingView];
    
    [self.tabBarView.superview bringSubviewToFront:self.tabBarView];
    
}

-(void)becameVisible {
    self.topChartCollectionView.scrollEnabled = NO;
    
    imageDatas = @[];
    previoustotalloading = 0;
    cellSizes = [[NSMutableArray alloc] init];
    
    [self loadNextImagesBatch];
    
}

-(void)loadNextImagesBatch {
    
    //todo: check the load conditions on load complete to verify that these are still valid when the load is done. Not doing this can cause a crash where images for something you clicked on forever ago are done loading when the view requirements have already changed.
    
    if (previoustotalloading >= imageDatas.count + 1) return;
    
    if (previoustotalloading == 0) loadingView.alpha = 1;
    
    previoustotalloading = imageDatas.count + 1;
    
    [SSAPI getTopSelfiesForMinimumAge:[SSAPI agemin] andMaximumAge:[SSAPI agemax] andGenders:[SSAPI genders] andVoteCategory:currentVoteType andDateType:currentDateType startingFromIndex:imageDatas.count onComplete:^(int totalSelfies, NSArray *images, NSError *error){
        
        self.topChartCollectionView.scrollEnabled = YES;
        
        loadingView.alpha = 0;
        
        if (error != nil) return;
        
        int prevCount = imageDatas.count;
        
        if (images.count == 0) {
            if (prevCount == 0) {
                [self.topChartCollectionView reloadData];
            }
            
            return;
        };
        
        
        
        imageDatas = [imageDatas arrayByAddingObjectsFromArray:images];
        
        //this function uses insertItemsAtIndexPaths instead of just reloadData, because the only thing that should change is the cells that are added; if you call reloadData, you'll also need to re-download all data for the currently visible cells, which will cause a noticeable glitch if they load data that is reloaded all the time. However, if you just swapped vote categories or changed the view, then it can't use insert, and it should reload data instead.
        
        if (prevCount == 0) {
            [self.topChartCollectionView reloadData];
            [self.topChartCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            
            return;
        }
        
        NSMutableArray *a = [[NSMutableArray alloc] init];
        for (int i = 0; i < images.count; i++) {
            NSIndexPath *p = [NSIndexPath indexPathForItem:prevCount + i inSection:0];
            [a addObject:p];
        }
        
        [self.topChartCollectionView insertItemsAtIndexPaths:a];
        
        
    }];
    
}
                                                        


- (void)showOrHideDropDownMenu:(id)sender {
    
    CGRect newDropdownMenuFrame = self.dropDownMenu.view.frame;
    //CGFloat newAlpha = 0.0;

    if (self.dropDownMenu.menuIsHidden == YES){
        
        newDropdownMenuFrame.origin.y = self.tabBarView.frame.size.height;
        self.dropDownMenu.menuIsHidden = NO;
        //newAlpha = 1.0;
        
    }
    else {
        
        newDropdownMenuFrame.origin.y = -200;
        self.dropDownMenu.menuIsHidden = YES;
        //newAlpha = 0.0;
        
    }
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.dropDownMenu.view.frame = newDropdownMenuFrame;
                         //self.dropDownMenu.view.alpha = newAlpha;
                     }
                     completion:nil];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == imageDatas.count - 3) [self loadNextImagesBatch];
    
    
    
    TopChartCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.rankingPlace.text = [NSString stringWithFormat:@"#%ld",(long)indexPath.item + 1];
    [cell startWithImageData:imageDatas[indexPath.item]];

    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    while (indexPath.item >= cellSizes.count) {
        CGSize cs = CGSizeMake(CELLWIDTH, CELLWIDTH);
        [cellSizes addObject:[NSValue valueWithCGSize:cs]];
    }
    //NSLog(@"size for item %i %@", indexPath.item, cellSizes[indexPath.item]);
    return [cellSizes[indexPath.item] CGSizeValue];
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    currentindex = -1;
    
    for (int i = 0; i < [self.topChartCollectionView visibleCells].count; i++) {
        TopChartCollectionViewCell* cell = self.topChartCollectionView.visibleCells[i];
        [cell setScoreViewStatus:NO instant:NO];
    }
    //[self.ratingButtonsController slideDownWithDuration:0.4];
    [self.tabBarView closeAllDropDownMenus];
    
    if(self.dropDownMenu.menuIsHidden == NO){
        [self showOrHideDropDownMenu:nil];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imageDatas.count;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    currentindex = indexPath.item;
    
    [self.tabBarView closeAllDropDownMenus];
    
    
    
    [self closeAllCellsExcept:indexPath.item];
    
    TopChartCollectionViewCell *cell = (TopChartCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [self setCellAtIndex:indexPath.item openStatus:!cell.open];
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
    /*
    [UIView transitionWithView:collectionView duration:2 options:UIViewAnimationOptionAllowAnimatedContent animations:^() {
        cell.frame = cr;
    } completion:^(BOOL finished){
        
    }];
    */
    
    return;
    
    
    
    
    TopChartCollectionViewCell *currentCell = (TopChartCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    currentCell.scoreViewForTopImages.soFunnyVotesLabel.text = [[imageDatas[indexPath.item] valueForKey:@"votes_funny"] valueForKey:@"count"];
    currentCell.scoreViewForTopImages.soHotVotesLabel.text = [[imageDatas[indexPath.item] valueForKey:@"votes_hot"] valueForKey:@"count"];
    currentCell.scoreViewForTopImages.soLameVotesLabel.text = [[imageDatas[indexPath.item] valueForKey:@"votes_lame"] valueForKey:@"count"];
    currentCell.scoreViewForTopImages.tryAgainVotesLabel.text = [[imageDatas[indexPath.item] valueForKey:@"votes_weird"] valueForKey:@"count"];
    
    
    [currentCell setScoreViewStatus:!currentCell.scoreViewIsVisible instant:NO];
    
    //[currentCell displayScoreViewOnTap];
    
    //NSLog (@"data is %@",imageDatas[indexPath.item]);
    
    /*
    [UIView animateWithDuration:0.4 animations:^() {
        self.topChartCollectionView.contentOffset = CGPointMake(0, collectionView.contentOffset.y);
    } completion:^(BOOL finished) {
        if (finished == YES){
            [self displayRatingButtonsController];
        }
        
    }];
    */

}

-(void)setCellAtIndex:(int)index openStatus:(BOOL)open {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    TopChartCollectionViewCell *cell = (TopChartCollectionViewCell*)[self.topChartCollectionView cellForItemAtIndexPath:indexPath];
    cell.open = open;
    CGRect cr = cell.frame;
    CGSize cs = [cellSizes[indexPath.item] CGSizeValue];
    float largeValue = cell.extraView.frame.origin.y + cell.extraView.frame.size.height;
    cs.height = open ? largeValue : 320;
    cr.size = cs;
    
    [self.topChartCollectionView performBatchUpdates:^() {
        
        [self.topChartCollectionView.collectionViewLayout invalidateLayout];
        
        cellSizes[indexPath.item] = [NSValue valueWithCGSize:cs];
        
    } completion:^(BOOL finished){
        
    }];
}

-(void)closeAllCellsExcept:(int)index {
    
    [self.topChartCollectionView performBatchUpdates:^() {
        
        [self.topChartCollectionView.collectionViewLayout invalidateLayout];
        
        for (int i = 0; i < cellSizes.count; i++) {
            if (i == index) continue;
            
            CGSize cs = [cellSizes[i] CGSizeValue];
            if (cs.height == 320) continue;
            cs.height = 320;
            
            cellSizes[i] = [NSValue valueWithCGSize:cs];
        }
        
        //cellSizes[indexPath.item] = [NSValue valueWithCGSize:cs];
        
    } completion:^(BOOL finished){
        
    }];
    
    
}

- (void)displayRatingButtonsController {
    
    CGRect newRatingButtonsControllerFrame = ratingButtonsViewController.view.frame;
    newRatingButtonsControllerFrame.origin.y = 0;

    
    [UIView animateWithDuration:0.4
                          delay:0.8
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         ratingButtonsViewController.view.frame = newRatingButtonsControllerFrame;
                     }
                     completion:nil];
    
}


- (void)fadeOutRatingButtonsController {
    
    float newAlpha = 0.0;
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         ratingButtonsViewController.view.alpha = newAlpha;
                     }
                     completion:^(BOOL finished){
                    if(finished){
                    [self returnRatingsButtinsControllerToTheDefaultPosition];}
                     }];
    
}

- (void)returnRatingsButtinsControllerToTheDefaultPosition {
    
     ratingButtonsViewController.view.alpha = 1.0;
    CGRect newRatingButtonsControllerFrame = ratingButtonsViewController.view.frame;
    newRatingButtonsControllerFrame.origin.y = -ratingButtonsViewController.soFunnyButton.frame.size.height *2;
    ratingButtonsViewController.view.frame = newRatingButtonsControllerFrame;
    
}


-(void)dropDownView:(SSDropDownView *)dropDownView clickedIndex:(int)index {
    
    [self.tabBarView closeAllDropDownMenus];
    
    NSDictionary *item = dropDownView.items[index];
    if (item[@"datetype"] != nil) currentDateType = [item[@"datetype"] integerValue];
    if (item[@"votetype"] != nil) currentVoteType = [item[@"votetype"] integerValue];
    
    UIColor *newColor = item[@"color"];
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.topChartCollectionView.backgroundColor = newColor;
                     }
                     completion:nil];
    
    [self becameVisible];
}




-(void)ratingButtonsViewController:(RatingButtonsViewController *)viewcontroller pressedVote:(SSVoteType)voteType {
    if (currentindex == -1) {
        [viewcontroller slideDownWithDuration:0.4];
        return;
    }
    
    NSDictionary *currentImageData = imageDatas[currentindex];
    
    NSString *accesstoken = currentImageData[@"accesstoken"];
    
    if (accesstoken == nil || (id)accesstoken == [NSNull null]) {
        [viewcontroller slideDownWithDuration:0.4];
        return;
    }
    
    
    [SSAPI voteForSelfieID:currentImageData[@"id"] andImageAccessToken:accesstoken andVote:voteType onComplete:^(BOOL success, NSError *possibleError){
        
        [viewcontroller slideDownWithDuration:0.4];
        
        if (success == false) return;
        
        NSMutableDictionary *d = [currentImageData mutableCopy];
        d[@"accesstoken"] = [NSNull null];
        
        NSMutableArray *a = [imageDatas mutableCopy];
        a[currentindex] = d;
        imageDatas = a;
        //this sets the new dictionary object in the cell that this originated from.
        [self.topChartCollectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:currentindex inSection:0]]];
    }];
    
}









@end


