//
//  ViewController.m
//  SoSelfie
//
//  Created by TYG on 17/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "ViewController.h"
#import "SSAPI.h"

@interface ViewController () {
    NSArray *imageDatas;
    SSVoteType currentVoteType;
    int previoustotalloading;
    int currentindex;
    RatingButtonsViewController *ratingButtonsViewController;
    UIView *basicView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentVoteType = SSVoteTypeFunny;
    
    //setting up collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.topChartCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60) collectionViewLayout:layout];
    self.topChartCollectionView.backgroundColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
    [self.topChartCollectionView setShowsVerticalScrollIndicator:NO];
    self.topChartCollectionView.dataSource = self;
    self.topChartCollectionView.delegate = self;
    [self.topChartCollectionView registerClass:[TopChartCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.view addSubview:self.topChartCollectionView];
    
    //setting dropdown menu
    
    self.dropDownMenu = [[DropDownMenu alloc] init];
    self.dropDownMenu.view.backgroundColor = [UIColor clearColor];
    self.dropDownMenu.view.frame = CGRectMake (180,-150,140,200);
    self.dropDownMenu.view.alpha = 1.0;
    //[self addChildViewController:self.dropDownMenu];
    [self.view addSubview:self.dropDownMenu.view];
    //[self.view bringSubviewToFront:self.dropDownMenu.view];
    
    
    //setting dropdown menu
    
    self.dropDownMenu.tableView.delegate = self;
    
    //setting up tabBarView
    
    self.tabBarView = [[TabBarView alloc] init];
    self.tabBarView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
    self.tabBarView.headerLabel.text = @"top selfies";
    self.tabBarView.filterButton.hidden = NO;
    [self.tabBarView.filterButton addTarget:self
                                     action:@selector(showOrHideDropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tabBarView];
    //[self.view bringSubviewToFront:self.tabBarView];
    
    
    
    //setting ratingButtonsController
    /*
    self.ratingButtonsController = [[RatingButtonsViewController alloc] init];
    self.ratingButtonsController.view.backgroundColor = [UIColor clearColor];
    self.ratingButtonsController.view.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, 320, 248);
    self.ratingButtonsController.delegate = self;
    //[self addChildViewController:self.ratingButtonsController];
    [self.view addSubview:self.ratingButtonsController.view];
    //[self.view bringSubviewToFront:self.ratingButtonsController.view];
    */
     
    imageDatas = @[];
    
    
    ratingButtonsViewController = [[RatingButtonsViewController alloc] initWithNibName:nil bundle:nil];
    ratingButtonsViewController.view.frame = CGRectMake(0, 380, self.view.frame.size.width, 0);
    ratingButtonsViewController.view.clipsToBounds = YES;
    [self.view addSubview:ratingButtonsViewController.view];
    
    ratingButtonsViewController.controllerIsDisplayed = NO;
    
    
    
    
}

-(void)becameVisible {
    imageDatas = @[];
    previoustotalloading = 0;
    
    [self loadNextImagesBatch];
    
    
}

-(void)loadNextImagesBatch {
    
    if (previoustotalloading >= imageDatas.count + 1) return;
    
    //NSLog(@"loading from %i", imageDatas.count);
    
    previoustotalloading = imageDatas.count + 1;
    
    [SSAPI getTopSelfiesForMinimumAge:[SSAPI agemin] andMaximumAge:[SSAPI agemax] andGenders:[SSAPI genders] andVoteCategory:currentVoteType startingFromIndex:imageDatas.count onComplete:^(int totalSelfies, NSArray *images, NSError *error){
        
        if (error != nil) return;
        
        if (images.count == 0) return;
        
        int prevCount = imageDatas.count;
        
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
    return CGSizeMake(320, 320);
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    currentindex = -1;
    
    //[self.ratingButtonsController slideDownWithDuration:0.4];
    
    [self showOrHideRatingButtonsControllerWithYOrigin:0.0];
    
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
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
    //[self.ratingButtonsController slideUp];
    
    float newYOrigin = [[UIScreen mainScreen] bounds].size.height - [collectionView cellForItemAtIndexPath:indexPath].frame.size.height - self.tabBarView.frame.size.height;
    
    [self showOrHideRatingButtonsControllerWithYOrigin:newYOrigin];
}

-(void)showOrHideRatingButtonsControllerWithYOrigin:(float)newYOrigin {
    
    CGRect newRatingButtonsControllerFrame = ratingButtonsViewController.view.frame;
    
    if (ratingButtonsViewController.controllerIsDisplayed == NO) {
    newRatingButtonsControllerFrame.size.height = newYOrigin;
    }
    else {
    newRatingButtonsControllerFrame.size.height = 0;
    }
    
    [UIView animateWithDuration:0.4
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         ratingButtonsViewController.view.frame = newRatingButtonsControllerFrame;
                     }
                     completion:nil];
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath  *)indexPath {
    self.tabBarView.filterButton.backgroundColor = [tableView cellForRowAtIndexPath:indexPath].backgroundColor;
    
    [self.tabBarView.filterButton setTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text forState:UIControlStateNormal];
    self.tabBarView.filterButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    currentVoteType = indexPath.row + 1;
    [self becameVisible];
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.topChartCollectionView.backgroundColor =  [tableView cellForRowAtIndexPath:indexPath].backgroundColor;
                     }
                     completion:nil];
    
    [self showOrHideDropDownMenu:nil];
    
    
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


