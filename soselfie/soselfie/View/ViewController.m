//
//  ViewController.m
//  SoSelfie
//
//  Created by TYG on 17/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //setting up collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.topChartCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    self.topChartCollectionView.backgroundColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
    [self.topChartCollectionView setShowsVerticalScrollIndicator:NO];
    self.topChartCollectionView.dataSource = self;
    self.topChartCollectionView.delegate = self;
    [self.topChartCollectionView registerClass:[TopChartCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier" ];
    [self.view addSubview:self.topChartCollectionView];
    
    //setting dropdown menu
    
    self.dropDownMenu = [[DropDownMenu alloc] init];
    self.dropDownMenu.view.backgroundColor = [UIColor clearColor];
    self.dropDownMenu.view.frame = CGRectMake (180,-150,140,200);
    self.dropDownMenu.view.alpha = 1.0;
    [self addChildViewController:self.dropDownMenu];
    [self.view addSubview:self.dropDownMenu.view];
    [self.view bringSubviewToFront:self.dropDownMenu.view];
    
    
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
    [self.view bringSubviewToFront:self.tabBarView];
    
    
    //setting testDataArray
    
    self.testDataArray = [[NSArray alloc] initWithObjects:
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          [UIImage imageNamed:@"scottish.jpeg"],
                          nil];
    
    //setting ratingButtonsController
    
    self.ratingButtonsController = [[RatingButtonsViewController alloc] init];
    self.ratingButtonsController.view.backgroundColor = [UIColor clearColor];
    self.ratingButtonsController.view.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, 320, 248);
    [self addChildViewController:self.ratingButtonsController];
    [self.view addSubview:self.ratingButtonsController.view];
    [self.view bringSubviewToFront:self.ratingButtonsController.view];
    
    
    
    

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
    
    
    
    TopChartCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.rankingPlace.text = [NSString stringWithFormat:@"#%ld",(long)indexPath.row];
    cell.selfieImageView.image = [self.testDataArray objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(320, 320);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (CGRectIntersectsRect(scrollView.bounds, CGRectMake(0, self.topChartCollectionView.contentSize.height, CGRectGetWidth(self.view.frame), 40)) && self.topChartCollectionView.contentSize.height > 0)
    {
        [self addMoreCells];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.ratingButtonsController slideDownWithDuration:0.8];
    
    if(self.dropDownMenu.menuIsHidden == NO){
        [self showOrHideDropDownMenu:nil];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.testDataArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSLog (@"Tapped indexPath is %ld",(long)indexPath.row);
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
    [self.ratingButtonsController slideUp];
}

- (void)addMoreCells{
NSLog (@"ADD MORE CELLS HERE");
NSArray *additionalTestArray = [self.testDataArray copy];
    
NSArray *newArray = [self.testDataArray arrayByAddingObjectsFromArray:additionalTestArray];

self.testDataArray = [NSArray arrayWithArray:newArray];
    
[self.topChartCollectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath  *)indexPath {
    self.tabBarView.filterButton.backgroundColor = [tableView cellForRowAtIndexPath:indexPath].backgroundColor;
    //self.tabBarView.filterButton.titleLabel.text = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    [self.tabBarView.filterButton setTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text forState:UIControlStateNormal];
    self.tabBarView.filterButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.topChartCollectionView reloadData];
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.topChartCollectionView.backgroundColor =  [tableView cellForRowAtIndexPath:indexPath].backgroundColor;
                     }
                     completion:nil];
    
    [self showOrHideDropDownMenu:nil];
    
    
}

@end
