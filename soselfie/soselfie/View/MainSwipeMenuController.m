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
	
    int spaceBetweenButtons;
    int buttonHeight;
    int firstGap;
    int secondGap;
    
    // iphone 4 or 5
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
    
    spaceBetweenButtons = 18;
    buttonHeight = 30;
    firstGap = 96;
    secondGap = 218;
    }
    
    else {
        
    spaceBetweenButtons = 12;
    buttonHeight = 25;
    firstGap = 58;
    secondGap = 202;
        
    }
    
    //vote Button
    
    self.voteButton = [[SwipeMenuButton alloc] initWithFrame:CGRectMake(5, 42,200,buttonHeight)];
    [self.voteButton setTitle:@"Vote!" forState:UIControlStateNormal];
    [self.view addSubview:self.voteButton];
    
    //Top selfies button
    
    self.topSelfies= [[SwipeMenuButton alloc] initWithFrame:CGRectMake(5, buttonHeight + spaceBetweenButtons + self.voteButton.frame.origin.y, 200,buttonHeight)];
    [self.topSelfies setTitle:@"Top Selfies" forState:UIControlStateNormal];
    [self.view addSubview:self.topSelfies];
    
    //Shoot one! button
    
    self.shootOne = [[SwipeMenuButton alloc] initWithFrame:CGRectMake(5, buttonHeight + spaceBetweenButtons + self.topSelfies.frame.origin.y,200,buttonHeight)];
    [self.shootOne setTitle:@"Shoot one!" forState:UIControlStateNormal];
    [self.view addSubview:self.shootOne];
    
    //Your selfies
    
    self.yourSelfiesButton = [[SwipeMenuButton alloc] initWithFrame:CGRectMake(5, buttonHeight + spaceBetweenButtons + self.shootOne.frame.origin.y,200,buttonHeight)];
    [self.yourSelfiesButton setTitle:@"Your selfies" forState:UIControlStateNormal];
    [self.view addSubview:self.yourSelfiesButton];
    
    NSLog (@"ORIGIN Y IS %f",self.yourSelfiesButton.frame.origin.y);
    
    
    //Settings block
    
    
    UIView *settingsBlockView = [[UIView alloc] initWithFrame:CGRectMake(0, self.yourSelfiesButton.frame.origin.y + firstGap, self.view.frame.size.width, 178)];
    settingsBlockView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:settingsBlockView];
    
    SwipeMenuButton *settingHeader = [[SwipeMenuButton alloc] initWithFrame:CGRectMake(5,0,200,30)];
    [settingHeader setTitle:@"Filter your selfies!" forState:UIControlStateNormal];
    settingHeader.userInteractionEnabled = NO;
    [settingsBlockView addSubview:settingHeader];

    UILabel *genderHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, 48, 100, 20)];
    genderHeader.text = @"Gender";
    genderHeader.backgroundColor = [UIColor clearColor];
    genderHeader.font = [UIFont fontWithName:@"MyriadPro-Bold" size:14];
    genderHeader.textColor = [UIColor whiteColor];
    [settingsBlockView addSubview:genderHeader];
    
    self.boysFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.boysFilterButton setTitle:@"BOYS" forState:UIControlStateNormal];
    [self.boysFilterButton setTitleEdgeInsets:UIEdgeInsetsMake(3, 0, 0, 0)];
    self.boysFilterButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:17];
    [self.boysFilterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.boysFilterButton.frame = CGRectMake(15, 71,122.5,35);
    [self.boysFilterButton addTarget:self
                         action:@selector(showOnlyBoysSelfies:)
               forControlEvents:UIControlEventTouchUpInside];
    self.boysFilterButton.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1];
    [settingsBlockView addSubview:self.boysFilterButton];
    
   
    
    self.girlsFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.girlsFilterButton setTitle:@"GIRLS" forState:UIControlStateNormal];
    [self.girlsFilterButton setTitleEdgeInsets:UIEdgeInsetsMake(3, 0, 0, 0)];
    self.girlsFilterButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:17];
    [self.girlsFilterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.girlsFilterButton.frame = CGRectMake(137.5,71,122.5,35);
    [self.girlsFilterButton addTarget:self
                          action:@selector(showOnlyGirlsSelfies:)
                forControlEvents:UIControlEventTouchUpInside];
    self.girlsFilterButton.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1];
    [settingsBlockView addSubview:self.girlsFilterButton];
    
    
    [self showOnlyBoysSelfies:self.boysFilterButton];
    
    self.boysButtonIsPressed = YES;
    [self showOnlyGirlsSelfies:self.girlsFilterButton];
    //self.girlsButtonIsPressed = NO;
    
     //genderButtons
    
    UILabel *ageHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, 112, 100, 20)];
    ageHeader.text = @"Age";
    ageHeader.backgroundColor = [UIColor clearColor];
    ageHeader.font = [UIFont fontWithName:@"MyriadPro-Bold" size:14];
    ageHeader.textColor = [UIColor whiteColor];
    [settingsBlockView addSubview:ageHeader];
    
    //ageSlider
    
    self.ageSlider = [[NMRangeSlider alloc] initWithFrame:CGRectMake(15, ageHeader.frame.origin.y + ageHeader.frame.size.height, 245, 35)];
    [self.ageSlider addTarget:self action:@selector(updateSliderLabels:) forControlEvents:UIControlEventValueChanged];
    [settingsBlockView addSubview:self.ageSlider];
    
    self.ageSlider.lowerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ageSlider.frame.origin.x, self.ageSlider.frame.origin.y + 30, 50, 50)];
    self.ageSlider.lowerLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:14];
    self.ageSlider.lowerLabel.textColor = [UIColor whiteColor];
    self.ageSlider.lowerLabel.backgroundColor = [UIColor clearColor];
    [settingsBlockView addSubview:self.ageSlider.lowerLabel];
    self.ageSlider.lowerLabel.text = [NSString stringWithFormat:@"%d",(int)self.ageSlider.lowerValue];
    
    
    self.ageSlider.upperLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, self.ageSlider.frame.origin.y + 20, 50, 50)];
    self.ageSlider.upperLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:14];
    self.ageSlider.upperLabel.textColor = [UIColor whiteColor];
    self.ageSlider.upperLabel.backgroundColor = [UIColor clearColor];
    [settingsBlockView addSubview:self.ageSlider.upperLabel];
    self.ageSlider.upperLabel.text = [NSString stringWithFormat:@"%d",(int)self.ageSlider.upperValue];
    
    
    //Erase account Button
    
    GenericSoSelfieButtonWithOptionalSubtitle *eraseAccountButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:CGRectMake(15,settingsBlockView.frame.origin.y + secondGap,245,35) withBackgroundColor:[UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1] highlightColor:[UIColor colorWithRed:(96/255.0) green:(96/255.0) blue:(96/255.0) alpha:1] titleLabel:@"Erase account" withFontSize:17];
    
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
