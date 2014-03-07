//
//  PopUpSelectGenderAgeController.m
//  soselfie
//
//  Created by TYG on 06/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "PopUpSelectGenderAgeController.h"
#import "SSAPI.h"

@interface PopUpSelectGenderAgeController (){
    
    RankingButtonWithSubtitle *selectionIsDoneButton;
    UIButton *maleGenderButton;
    UIButton *femaleGednerButton;
    NMRangeSlider *yourAgeIsSlider;
    
    BOOL maleGenderButtonIsPressed;
    BOOL femaleGenderButtonIsPressed;
}

@end

@implementation PopUpSelectGenderAgeController


- (void)start
{
    
    int bottomButtonHeight;
    int bottomInset;
    int logoWidth;
    int logoHeight;
    int logoOriginY;
    int zeroGap;
    int firstGap;
    int secondGap;
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
        
        bottomButtonHeight = 92;
        bottomInset = 0;
        logoWidth = 71.5;
        logoHeight = 78;
        logoOriginY = 35;
        zeroGap = 95;
        firstGap = 108;
        secondGap = 95;
        
    }
    else {
        
        bottomButtonHeight = 60;
        bottomInset = 15;
        firstGap = 100;
        logoWidth = 40;
        logoHeight = 44;
        logoOriginY = 44;
        zeroGap = 65;
        firstGap = 100;
        secondGap = 92;
        
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - logoWidth)/2, logoOriginY, logoWidth, logoHeight)];
    logoImageView.image = [UIImage imageNamed:@"iphone5_textless_logo"];
    [self.view addSubview:logoImageView];
    
    UILabel *weCanNotDetectLabel = [[UILabel alloc] initWithFrame:CGRectMake (22, logoImageView.frame.origin.y + zeroGap, 276, 70)];
    weCanNotDetectLabel.text = @"We can't detect your age or gender through Facebook. Can you help?";
    weCanNotDetectLabel.backgroundColor = [UIColor clearColor];
    weCanNotDetectLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:20];
    weCanNotDetectLabel.textColor = [UIColor colorWithRed:88/255.0 green:89/255.0 blue:91/255.0 alpha:1.0];
    weCanNotDetectLabel.textAlignment = NSTextAlignmentCenter;
    weCanNotDetectLabel.lineBreakMode = NSLineBreakByWordWrapping;
    weCanNotDetectLabel.numberOfLines = 3;
    [self.view addSubview:weCanNotDetectLabel];
    
    selectionIsDoneButton = [[RankingButtonWithSubtitle alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - bottomButtonHeight, 320, bottomButtonHeight)];
    selectionIsDoneButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:25];
    selectionIsDoneButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [selectionIsDoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    selectionIsDoneButton.backgroundColor = [UIColor colorWithRed:176/255.0 green:208/255.0 blue:53/255.0 alpha:1.0];
    [selectionIsDoneButton setTitle:@"Done!" forState:UIControlStateNormal];
    //[selectionIsDoneButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, bottomInset, 0)];
    [selectionIsDoneButton setBackgroundImage:[RankingButtonWithSubtitle imageWithColor:[UIColor colorWithRed:(197/255.0) green:(229/255.0) blue:(62/255.0) alpha:1]] forState:UIControlStateHighlighted];
    [selectionIsDoneButton addTarget:self action:@selector(selectionIsDoneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectionIsDoneButton];
    
    //gedner label and buttons view
    
    UIView *genderLabelAndButtonsView = [[UIView alloc] initWithFrame:CGRectMake(0, weCanNotDetectLabel.frame.origin.y + firstGap, self.view.frame.size.width, 100)];
    genderLabelAndButtonsView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:genderLabelAndButtonsView];
    
    UILabel *youAreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 21)];
    youAreLabel.text = @"You are a...";
    youAreLabel.textAlignment = NSTextAlignmentCenter;
    youAreLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:20];
    youAreLabel.textColor = [UIColor colorWithRed:88/255.0 green:89/255.0 blue:91/255.0 alpha:1.0];
    youAreLabel.backgroundColor = [UIColor clearColor];
    [genderLabelAndButtonsView addSubview:youAreLabel];
    
    maleGenderButton = [[UIButton alloc] initWithFrame:CGRectMake(47, youAreLabel.frame.origin.y + 25 , 113, 35)];
    [maleGenderButton setTitle:@"MALE" forState:UIControlStateNormal];
    [maleGenderButton setTitleEdgeInsets:UIEdgeInsetsMake(3, 0, 0, 0)];
    maleGenderButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:18];
    [maleGenderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [maleGenderButton addTarget:self
                         action:@selector(maleGenderWasSelected:)
               forControlEvents:UIControlEventTouchUpInside];
    maleGenderButton.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1];
    [genderLabelAndButtonsView addSubview:maleGenderButton];
    
    femaleGednerButton = [[UIButton alloc] initWithFrame:CGRectMake(160, youAreLabel.frame.origin.y + 25, 113, 35)];
    [femaleGednerButton setTitle:@"FEMALE" forState:UIControlStateNormal];
    [femaleGednerButton setTitleEdgeInsets:UIEdgeInsetsMake(3, 0, 0, 0)];
    femaleGednerButton.titleLabel.font =  [UIFont fontWithName:@"Tondu-Beta" size:18];
    [femaleGednerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [femaleGednerButton addTarget:self
                           action:@selector(femaleGenderWasSelected:)
                 forControlEvents:UIControlEventTouchUpInside];
    femaleGednerButton.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1];
    [genderLabelAndButtonsView addSubview:femaleGednerButton];
   
    
    [self maleGenderWasSelected:maleGenderButton];
    maleGenderButtonIsPressed = YES;
    
    //age label and buttons view
    
    UIView *ageLabelAndButtonsView = [[UIView alloc] initWithFrame:CGRectMake(0, genderLabelAndButtonsView.frame.origin.y + secondGap, self.view.frame.size.width, 100)];
    ageLabelAndButtonsView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:ageLabelAndButtonsView];
    
    UILabel *yourAgeIsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 21)];
    yourAgeIsLabel.text = @"Your age is...";
    yourAgeIsLabel.textAlignment = NSTextAlignmentCenter;
    yourAgeIsLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:20];
    yourAgeIsLabel.textColor = [UIColor colorWithRed:88/255.0 green:89/255.0 blue:91/255.0 alpha:1.0];
    yourAgeIsLabel.backgroundColor = [UIColor clearColor];
    [ageLabelAndButtonsView addSubview:yourAgeIsLabel];
    
    yourAgeIsSlider = [[NMRangeSlider alloc] initWithFrame:CGRectMake(47,yourAgeIsLabel.frame.origin.y + 25,226,35)];
    yourAgeIsSlider.upperHandleHidden = YES;
    [ageLabelAndButtonsView addSubview:yourAgeIsSlider];
    [yourAgeIsSlider addTarget:self action:@selector(updateSliderLabel:) forControlEvents:UIControlEventValueChanged];
    
    yourAgeIsSlider.lowerLabel = [[UILabel alloc] initWithFrame:CGRectMake(yourAgeIsSlider.frame.origin.x, yourAgeIsSlider.frame.origin.y + 20, 50, 50)];
    yourAgeIsSlider.lowerLabel.font = [UIFont fontWithName:@"Tondu-Beta" size:14];
    yourAgeIsSlider.lowerLabel.textColor = [UIColor colorWithRed:88/255.0 green:89/255.0 blue:91/255.0 alpha:1.0];
    yourAgeIsSlider.lowerLabel.backgroundColor = [UIColor clearColor];
    [ageLabelAndButtonsView addSubview:yourAgeIsSlider.lowerLabel];
    yourAgeIsSlider.lowerLabel.text = [NSString stringWithFormat:@"%d",(int)yourAgeIsSlider.lowerValue];
    

    
}

- (void)updateSliderLabel:(NMRangeSlider *)ageslider
{
    //LOWER LABEL
    
    CGPoint lowerCenter;
    lowerCenter.x = (yourAgeIsSlider.lowerCenter.x +  yourAgeIsSlider.frame.origin.x);
    lowerCenter.y = (yourAgeIsSlider.center.y + 30.0f);
    
    int age = (int)yourAgeIsSlider.lowerValue;
    
    yourAgeIsSlider.lowerLabel.center = lowerCenter;
    yourAgeIsSlider.lowerLabel.text = [NSString stringWithFormat:@"%d", age];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *today = [NSDate date];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:today];
    
    [SSAPI setUserBirthday:[NSString stringWithFormat:@"%i", components.day] month:[NSString stringWithFormat:@"%i", components.month] year:[NSString stringWithFormat:@"%i", components.year - age]];
    
}


- (void)maleGenderWasSelected:(UIButton *)button {
    
    if (maleGenderButtonIsPressed == NO){
        button.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
        maleGenderButtonIsPressed = YES;
        
        [SSAPI setUserGender:SSUserGenderMale];
        
        if (femaleGenderButtonIsPressed == YES){
            [self femaleGenderWasSelected:femaleGednerButton];
        }
    }
    else {
        button.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1];
        maleGenderButtonIsPressed = NO;
        
        if (femaleGenderButtonIsPressed == NO){
            [self femaleGenderWasSelected:femaleGednerButton];
        }
        
    }
    
    
}

- (void)femaleGenderWasSelected:(UIButton *)button {
    
    if (femaleGenderButtonIsPressed == NO){
        button.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
        femaleGenderButtonIsPressed = YES;
        
        
        [SSAPI setUserGender:SSUserGenderFemale];
        
        if (maleGenderButtonIsPressed == YES){
            [self maleGenderWasSelected:maleGenderButton];
        }
    
        
        
    }
    else {
        button.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(76/255.0) blue:(76/255.0) alpha:1];
        femaleGenderButtonIsPressed = NO;
        
        if (maleGenderButtonIsPressed == NO){
            [self maleGenderWasSelected:maleGenderButton];
        }
    
    }
    
}


-(void)selectionIsDoneButtonClicked:(id)sender {
    NSArray *a = [SSAPI isProfileInfoReadyToBeSentToServer];
    
    if (a.count == 0) {
        [self.delegate popUpSelectGenderAgeControllerReadyToLogin:self];
        return;
    }
    
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Missing login info" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    NSString *s = a[0];
    if ([s isEqualToString:@"birthday"]) {
        v.message = @"Please enter your age.";
    } else if ([s isEqualToString:@"gender"]) {
        v.message = @"Please enter your gender.";
    }
    
    [v show];
}


@end
