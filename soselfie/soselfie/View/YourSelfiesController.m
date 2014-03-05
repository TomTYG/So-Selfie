//
//  YourSelfiesController.m
//  SoSelfie
//
//  Created by TYG on 28/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "YourSelfiesController.h"

@interface YourSelfiesController ()

@end

@implementation YourSelfiesController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //setting up collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.yourSelfiesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    self.yourSelfiesCollectionView .backgroundColor = [UIColor whiteColor];
    [self.yourSelfiesCollectionView setShowsVerticalScrollIndicator:NO];
    self.yourSelfiesCollectionView .dataSource = self;
    self.yourSelfiesCollectionView.delegate = self;
    [self.yourSelfiesCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier" ];
    [self.view addSubview:self.yourSelfiesCollectionView];
    
    [self.yourSelfiesCollectionView registerClass:[SelfiesCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier" ];
    
    //setting up the tabbarview
    
    self.tabBarView = [[TabBarView alloc] init];
    self.tabBarView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
    //self.tabBarView.headerLabel.frame = CGRectMake(50, 10, 140, 60);
    self.tabBarView.headerLabel.text = @"your selfies";
    self.tabBarView.shootButton.hidden = NO;
    [self.view addSubview:self.tabBarView];
    [self.view bringSubviewToFront:self.tabBarView];
    
    UIView *topPinkHeader = [[UIView alloc] initWithFrame:CGRectMake(0,60,320,20)];
    topPinkHeader.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    [self.view addSubview:topPinkHeader];
    
    UILabel *voteHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, 0, 50, 20)];
    voteHeaderLabel.text = @"votes";
    voteHeaderLabel.textColor = [UIColor whiteColor];
    voteHeaderLabel.backgroundColor = [UIColor clearColor];
    voteHeaderLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:12];
    [topPinkHeader addSubview:voteHeaderLabel];
    
    UILabel *rankHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 0, 50, 20)];
    rankHeaderLabel.text = @"rank";
    rankHeaderLabel.textColor = [UIColor whiteColor];
    rankHeaderLabel.backgroundColor = [UIColor clearColor];
    rankHeaderLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:12];
    [topPinkHeader addSubview:rankHeaderLabel];
    
    //testdatarray
    
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
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SelfiesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.imageThumbView.image = [self.testDataArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width,115);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
