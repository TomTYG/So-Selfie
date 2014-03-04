//
//  MainSwipeMenuController.m
//  SoSelfie
//
//  Created by TYG on 20/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "MainSwipeMenuController.h"

@interface MainSwipeMenuController ()

@end

@implementation MainSwipeMenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:(48/255.0) green:(48/255.0) blue:(48/255.0) alpha:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //vote Button
    
    self.voteButton = [[SwipeMenuButton alloc] initWithFrame:CGRectMake(5, 42,200,30)];
    [self.voteButton setTitle:@"Vote!" forState:UIControlStateNormal];
    [self.view addSubview:self.voteButton];
    
    //Top selfies button
    
    self.topSelfies= [[SwipeMenuButton alloc] initWithFrame:CGRectMake(5, 90,200,30)];
    [self.topSelfies setTitle:@"Top Selfies" forState:UIControlStateNormal];
    [self.view addSubview:self.topSelfies];
    
    //Shoot one! button
    
    self.shootOne = [[SwipeMenuButton alloc] initWithFrame:CGRectMake(5, 138,200,30)];
    [self.shootOne setTitle:@"Shoot one!" forState:UIControlStateNormal];
    [self.view addSubview:self.shootOne];
    
    //Your selfies
    
    self.yourSelfiesButton = [[SwipeMenuButton alloc] initWithFrame:CGRectMake(5, 186,200,30)];
    [self.yourSelfiesButton setTitle:@"Your selfies" forState:UIControlStateNormal];
    [self.view addSubview:self.yourSelfiesButton];
    
    
    
    //Settings block
    
    UILabel *settingHeader = [[UILabel alloc] initWithFrame:CGRectMake(15,282,200,30)];
    settingHeader.text = @"Settings";
    settingHeader.font = [UIFont fontWithName:@"MyriadPro-Bold" size:18];
    settingHeader.textColor = [UIColor whiteColor];
    settingHeader.backgroundColor = [UIColor clearColor];
    [self.view addSubview:settingHeader];
    
    UILabel *genderHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, 330, 100, 20)];
    genderHeader.text = @"Gender";
    genderHeader.backgroundColor = [UIColor clearColor];
    genderHeader.font = [UIFont fontWithName:@"MyriadPro-Bold" size:14];
    genderHeader.textColor = [UIColor whiteColor];
    [self.view addSubview:genderHeader];
    
    self.boysFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.boysFilterButton setTitle:@"BOYS" forState:UIControlStateNormal];
    self.boysFilterButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:17];
    [self.boysFilterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.boysFilterButton.frame = CGRectMake(15, 353,105,35);
    [self.boysFilterButton addTarget:self
                         action:@selector(showOnlyBoysSelfies:)
               forControlEvents:UIControlEventTouchUpInside];
    self.boysFilterButton.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1];
    [self.view addSubview:self.boysFilterButton];
    
   
    
    self.girlsFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.girlsFilterButton setTitle:@"GIRLS" forState:UIControlStateNormal];
    self.girlsFilterButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:17];
    [self.girlsFilterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.girlsFilterButton.frame = CGRectMake(120,353,105,35);
    [self.girlsFilterButton addTarget:self
                          action:@selector(showOnlyGirlsSelfies:)
                forControlEvents:UIControlEventTouchUpInside];
    self.girlsFilterButton.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1];
    [self.view addSubview:self.girlsFilterButton];
    
    
    [self showOnlyBoysSelfies:self.boysFilterButton];
    self.boysButtonIsPressed = YES;
    self.girlsButtonIsPressed = NO;
    
     //genderButtons
    
    UILabel *ageHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, 402, 100, 20)];
    ageHeader.text = @"Age";
    ageHeader.backgroundColor = [UIColor clearColor];
    ageHeader.font = [UIFont fontWithName:@"MyriadPro-Bold" size:14];
    ageHeader.textColor = [UIColor whiteColor];
    [self.view addSubview:ageHeader];
    
    [self.view addSubview:ageHeader];
    
    //ageSlider
    
    self.ageSlider = [[NMRangeSlider alloc] initWithFrame:CGRectMake(15, 410, 210, 70)];
    [self.ageSlider addTarget:self action:@selector(updateSliderLabels:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.ageSlider];
    
    self.ageSlider.lowerLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 460, 50, 50)];
    self.ageSlider.lowerLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:14];
    self.ageSlider.lowerLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.ageSlider.lowerLabel];
    self.ageSlider.lowerLabel.text = [NSString stringWithFormat:@"%d",(int)self.ageSlider.lowerValue];
    
    
    self.ageSlider.upperLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 460, 50, 50)];
    self.ageSlider.upperLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:14];
    self.ageSlider.upperLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.ageSlider.upperLabel];
    self.ageSlider.upperLabel.text = [NSString stringWithFormat:@"%d",(int)self.ageSlider.upperValue];
    
    //Erase account Button
    
    UIButton *eraseAccountButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [eraseAccountButton setTitle:@"Erase account" forState:UIControlStateNormal];
    eraseAccountButton.titleLabel.font =  [UIFont fontWithName:@"MyriadPro-Bold" size:17];
    [eraseAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    eraseAccountButton.frame = CGRectMake(15,500,210,35);
    /*[girlsFilterButton addTarget:self
                          action:@selector(showOnlyGirlsSelfies:)
                forControlEvents:UIControlEventTouchUpInside];*/
    eraseAccountButton.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1];
    [self.view addSubview:eraseAccountButton];
    
}

- (void)updateSliderLabels:(NMRangeSlider *)ageslider
{
    // You get get the center point of the slider handles and use this to arrange other subviews
    
    //LOWER LABEL
    
    CGPoint lowerCenter;
    lowerCenter.x = (self.ageSlider.lowerCenter.x + self.ageSlider.frame.origin.x);
    lowerCenter.y = (self.ageSlider.center.y + 40.0f);
    
    self.ageSlider.lowerLabel.center = lowerCenter;
    self.ageSlider.lowerLabel.text = [NSString stringWithFormat:@"%d", (int)self.ageSlider.lowerValue];
    NSLog (@"LOWER VALUE IS %f",self.ageSlider.lowerValue);
    
    //UPPER LABEL
    
    CGPoint upperCenter;
    upperCenter.x = (self.ageSlider.upperCenter.x + self.ageSlider.frame.origin.x + 30);
    upperCenter.y = (self.ageSlider.center.y + 40.0f);
    
    self.ageSlider.upperLabel.center = upperCenter;
    self.ageSlider.upperLabel.text = [NSString stringWithFormat:@"%d", (int)self.ageSlider.upperValue];
    NSLog (@"UPPER VALUE IS %f",self.ageSlider.upperValue);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swipeMenuFromTheLeftSide:(id)sender{
    NSLog (@"It is getting called");
}

- (void) showOnlyBoysSelfies:(UIButton *)button  {
    if (self.boysButtonIsPressed == NO){
        button.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
        self.boysButtonIsPressed = YES;
        }
    else {
        button.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1];
        self.boysButtonIsPressed = NO;
        
            if (self.girlsButtonIsPressed == NO){
                [self showOnlyGirlsSelfies:self.girlsFilterButton];
            }
            else {
                //do nothing
            }
        
    }
}

- (void) showOnlyGirlsSelfies:(UIButton *)button {
    if (self.girlsButtonIsPressed == NO){
    button.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    self.girlsButtonIsPressed = YES;
    }
    else {
    button.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1];
    self.girlsButtonIsPressed = NO;
        
        if (self.boysButtonIsPressed == NO){
            [self showOnlyBoysSelfies:self.boysFilterButton];
        }
        else {
            //do nothing
        }
    }
}


@end
