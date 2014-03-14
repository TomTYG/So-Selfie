//
//  SSDropDownView.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 13/03/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "SSDropDownView.h"
#import "GenericSoSelfieButtonWithOptionalSubtitle.h"
#import "SSMacros.h"

@interface SSDropDownView() {
    
    BOOL menuVisible;
}

@property UICollectionView *collectionView;
@property GenericSoSelfieButtonWithOptionalSubtitle *currentButton;
@property CGSize cellSize;

@end

@implementation SSDropDownView

-(instancetype)initWithFrame:(CGRect)frame andCellSize:(CGSize)cellSize andNameAndColorsArray:(NSArray *)array {
    
    self = [super initWithFrame:frame];
    self.clipsToBounds = YES;
    
    self.items = array;
    self.cellSize = cellSize;
    
    menuVisible = false;
    
    UICollectionViewFlowLayout *f = [[UICollectionViewFlowLayout alloc] init];
    f.scrollDirection = UICollectionViewScrollDirectionVertical;
    f.minimumLineSpacing = 0;
    f.minimumInteritemSpacing = 0;
    
    if (self.items.count == 0) return self;
    
    NSDictionary *item = self.items[0];
    self.currentButton = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:self.bounds withBackgroundColor:item[@"color"] highlightColor:item[@"colorHighlighted"] titleLabel:item[@"name"] withFontSize:15];
    [self.currentButton addTarget:self action:@selector(currentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.currentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.currentButton.contentEdgeInsets = UIEdgeInsetsMake(1, 10, 0, 0);
    [self addSubview:self.currentButton];
    
    float height = self.currentButton.titleLabel.font.pointSize + 4;
    float width = 20;
    UILabel *arrowlabel = [[UILabel alloc] initWithFrame:CGRectMake(self.currentButton.frame.size.width - width - 6, 0.5 * self.currentButton.frame.size.height - 0.5 * height + 1, width, height)];
    arrowlabel.textAlignment = NSTextAlignmentRight;
    arrowlabel.textColor = [self.currentButton titleColorForState:UIControlStateNormal];
    arrowlabel.text = @"▼";
    arrowlabel.backgroundColor = [UIColor clearColor];
    [self.currentButton addSubview:arrowlabel];
    
    CGRect cr = self.currentButton.bounds;
    cr.origin.y += cr.size.height + 6;
    cr.size.width = self.cellSize.width;
    cr.size.height = self.cellSize.height * self.items.count;
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:cr collectionViewLayout:f];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ssdropdowncell"];
    
    
    //[self setDropDownMenuVisibility:NO instant:YES];
    
    return self;
}


-(void)currentButtonClicked:(id)sender {
    [self toggleDropDownMenu];
}



-(void)toggleDropDownMenu {
    [self setDropDownMenuVisibility:!menuVisible instant:NO];
    
}
-(void)setDropDownMenuVisibility:(BOOL)visibility instant:(BOOL)instant {
    menuVisible = visibility;
    
    CGRect cr = self.frame;
    
    if (menuVisible == true) {
        [self addSubview:self.collectionView];
        cr.size.width = menuVisible ? self.collectionView.frame.size.width : self.currentButton.frame.size.width;
        self.frame = cr;
        
        cr.size.height = self.collectionView.frame.origin.y + self.collectionView.frame.size.height;
    } else {
        cr.size.height = self.currentButton.frame.size.height;
    }
    
    NSTimeInterval duration = instant == true ? 0 : 0.2;
    
    [UIView animateWithDuration:duration animations:^() {
        self.frame = cr;
    } completion:^(BOOL finished){
        if (menuVisible == false) {
            [self.collectionView removeFromSuperview];
            CGRect c = self.frame;
            c.size.width = self.currentButton.frame.size.width;
            self.frame = c;
        }
    }];
    
    
}





-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ssdropdowncell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSDictionary *item = self.items[indexPath.item];
    
    GenericSoSelfieButtonWithOptionalSubtitle *g = [[GenericSoSelfieButtonWithOptionalSubtitle alloc] initWithFrame:cell.bounds withBackgroundColor:item[@"color"] highlightColor:item[@"colorHighlighted"] titleLabel:item[@"name"] withFontSize:15];
    g.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    g.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [g addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:g];
    
    
    return cell;
}


-(void)buttonClicked:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSString *s = button.titleLabel.text;
    
    for (int i = 0; i < self.items.count; i++) {
        
        if ([self.items[i][@"name"] isEqualToString:s] == true) {
            
            [self selectIndex:i triggerDelegate:true];
            
            break;
            
        }
    }
}

-(void)selectIndex:(int)index triggerDelegate:(BOOL)triggerDelegate {
    NSDictionary *item = self.items[index];
    
    if (triggerDelegate == true) [self.delegate dropDownView:self clickedIndex:index];
    
    [self.currentButton setTitle:item[@"name"] forState:UIControlStateNormal];
    [self.currentButton setbackgroundColorNormal:item[@"color"]];
    [self.currentButton setbackgroundColorHighlighted:item[@"colorHighlighted"]];
    
    if (triggerDelegate == false) [self setDropDownMenuVisibility:NO instant:NO];
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.cellSize;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.items.count;
}


@end
