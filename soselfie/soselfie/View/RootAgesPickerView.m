//
//  RootAgesPickerView.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 28/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "RootAgesPickerView.h"

@interface RootAgesPickerView() {
    UILabel *labelmin;
    UILabel *labelmax;
    
    int MINIMUM;
    int MAXIMUM;
}

@end

@implementation RootAgesPickerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    MINIMUM = 13;
    MAXIMUM = 34;
    
    float fontsize = 14;
    labelmin = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 0.5 * self.frame.size.width, fontsize + 4)];
    labelmin.text = @"Minimum age:";
    labelmin.textAlignment = NSTextAlignmentCenter;
    labelmin.font = [UIFont systemFontOfSize:fontsize];
    [self addSubview:labelmin];
    
    labelmax = [[UILabel alloc] initWithFrame:CGRectMake(0.5 * self.frame.size.width, 10, 0.5 * self.frame.size.width, fontsize + 4)];
    labelmax.text = @"Maximum age:";
    labelmax.textAlignment = NSTextAlignmentCenter;
    labelmax.font = [UIFont systemFontOfSize:fontsize];
    [self addSubview:labelmax];
    
    self.minimumAgePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(30, 0, 100, 50)];
    self.minimumAgePicker.delegate = self;
    self.minimumAgePicker.dataSource = self;
    [self addSubview:self.minimumAgePicker];
    
    self.maximumAgePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(self.frame.size.width - 100 - 30, 0, 100, 10)];
    self.maximumAgePicker.delegate = self;
    self.maximumAgePicker.dataSource = self;
    [self addSubview:self.maximumAgePicker];
    [self.maximumAgePicker selectRow:[self.maximumAgePicker numberOfRowsInComponent:0] - 1 inComponent:0 animated:NO];
    
    return self;
}

-(int)getminimumage {
    return [self.minimumAgePicker selectedRowInComponent:0] + MINIMUM;
}
-(int)getmaximumage {
    return [self.maximumAgePicker selectedRowInComponent:0] + MINIMUM;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return MAXIMUM - MINIMUM + 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return pickerView.frame.size.width;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%i", row + MINIMUM];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //NSLog(@"selected row %i", [pickerView selectedRowInComponent:component]);
}
@end
