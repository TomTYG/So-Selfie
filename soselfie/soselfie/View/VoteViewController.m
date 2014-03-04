//
//  VoteViewController.m
//  SoSelfie
//
//  Created by TYG on 26/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "VoteViewController.h"

@interface VoteViewController () {
    long selfieCellCounter;
}

@end

@implementation VoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
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
        self.tabBarView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
        self.tabBarView.headerLabel.text = @"vote";
        self.tabBarView.shootButton.hidden = NO;
        [self.view addSubview:self.tabBarView];
        [self.view bringSubviewToFront:self.tabBarView];
        
        
        /*
        self.singlePhotoPageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        self.singlePhotoPageViewController.delegate = self;
        self.singlePhotoPageViewController.dataSource = self;
        
        CGRect pageViewRect = self.view.bounds;
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
        self.singlePhotoPageViewController.view.frame = pageViewRect;
        */
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selfieCellCounter = 1;
	
     self.testArray =  [[NSArray alloc] initWithObjects:
     [UIImage imageNamed:@"scottish.jpeg"],
     [UIImage imageNamed:@"scottish.jpeg"],
     nil];
    
    static NSString *const ratingButtonIsPressed = @"RatingButtonIsPressed";
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(scrollToRight:)
                                                 name: ratingButtonIsPressed
                                               object: nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.testArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    VoteCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor clearColor];
    
    cell.photoImageView.image = [self.testArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}

- (void)scrollToRight: (id)sender
{
    NSLog (@"Number of selfies is %lu", (unsigned long)self.testArray.count);
    NSLog(@"Counter is %li", selfieCellCounter);
    
    /*
    if(selfieCellCounter == self.testArray.count) {
        [self addMoreCells];
    }
    */
    
    selfieCellCounter = MIN(MAX(self.testArray.count-1,0), ++selfieCellCounter);
    [self.mainVoteCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:selfieCellCounter inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int spacing = 10;
    
    float contentOffsetWhenFullyScrolledRight = (self.mainVoteCollectionView.frame.size.width + spacing) *(self.testArray.count -1);
    
    NSLog (@"CONTENT OFFSET IS %f",scrollView.contentOffset.x);
    //NSLog (@"fullyscrtolledright is %f",contentOffsetWhenFullyScrolledRight);
    
    
     if (scrollView.contentOffset.x == contentOffsetWhenFullyScrolledRight) {
         [self addMoreCells];
     }
    
}


- (void)addMoreCells{
    NSLog (@"ADD MORE CELLS HERE");
    NSArray *additionalTestArray = [self.testArray copy];
    
    NSArray *newArray = [self.testArray arrayByAddingObjectsFromArray:additionalTestArray];
    
    self.testArray = [NSArray arrayWithArray:newArray];
    
    [self.mainVoteCollectionView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
