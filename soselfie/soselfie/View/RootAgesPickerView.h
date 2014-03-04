//
//  RootAgesPickerView.h
//  soselfie
//
//  Created by Tom van Kruijsbergen on 28/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootAgesPickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

@property UIPickerView *minimumAgePicker;
@property UIPickerView *maximumAgePicker;

-(int)getminimumage;
-(int)getmaximumage;

@end
