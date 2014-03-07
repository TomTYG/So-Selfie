//
//  YourSelfiesController.m
//  SoSelfie
//
//  Created by TYG on 28/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "YourSelfiesController.h"
#import "SSAPI.h"
@interface YourSelfiesController () {
    NSArray *imageDatas;
    int previoustotalloading;
}

@end

@implementation YourSelfiesController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //setting up collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.yourSelfiesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 80) collectionViewLayout:layout];
    self.yourSelfiesCollectionView .backgroundColor = [UIColor whiteColor];
    [self.yourSelfiesCollectionView setShowsVerticalScrollIndicator:NO];
    self.yourSelfiesCollectionView .dataSource = self;
    self.yourSelfiesCollectionView.delegate = self;
    [self.view addSubview:self.yourSelfiesCollectionView];
    
    [self.yourSelfiesCollectionView registerClass:[SelfiesCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier" ];
    
    //setting up the tabbarview
    
    self.tabBarView = [[TabBarView alloc] init];
    self.tabBarView.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
    //self.tabBarView.headerLabel.frame = CGRectMake(50, 10, 140, 60);
    self.tabBarView.headerLabel.text = @"your selfies";
    self.tabBarView.shootButton.hidden = NO;
    [self.view addSubview:self.tabBarView];
    
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
    
    imageDatas = @[];
    
}

-(void)becameVisible {
    imageDatas = @[];
    previoustotalloading = 0;
    
    [self loadNextImagesBatch];
    
}
-(void)userloggedout {
    imageDatas = @[];
    previoustotalloading = 0;
    
    [self.yourSelfiesCollectionView reloadData];
    
}


-(void)loadNextImagesBatch {
    
    //this uses + 1 everywhere, so that previoustotalloading can be 0 and imagedata also 0, and it will still go through this function.
    if (previoustotalloading >= imageDatas.count + 1) return;
    
    //NSLog(@"loading from %i", imageDatas.count);
    
    previoustotalloading = imageDatas.count + 1;
    [SSAPI getOwnSelfiesStartingFromIndex:imageDatas.count onComplete:^(int totalSelfies, NSArray *images, NSError *error){
        if (error != nil) return;
        
        imageDatas = [imageDatas arrayByAddingObjectsFromArray:images];
        
        [self.yourSelfiesCollectionView reloadData];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //you could load a new batch earlier, if you like, by adjusting the number.
    if (indexPath.item == imageDatas.count - 3) [self loadNextImagesBatch];
    
    SelfiesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.delegate = self;
    [cell startWithImageData:imageDatas[indexPath.item]];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageDatas.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width,115);
}


-(void)selfiesCollectionViewCell:(SelfiesCollectionViewCell *)cell pressedDeleteWithImageData:(NSDictionary *)imageData {
    
    
    [SSAPI eraseSelfieID:imageData[@"id"] onComplete:^(BOOL success, NSError *possibleError){
        if (success == false) return;
        
        int index = [imageDatas indexOfObject:imageData];
        
        //this should never happen. How can we properly fail if this does end up happening?
        if (index < 0) return;
        
        NSMutableArray *a = [imageDatas mutableCopy];
        [a removeObjectAtIndex:index];
        previoustotalloading--;
        imageDatas = a;
        
        
        [self.yourSelfiesCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:index inSection:0]]];
    }];
    
    
    
}

@end
