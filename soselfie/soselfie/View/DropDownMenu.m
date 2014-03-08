//
//  DropDownMenu.m
//  SoSelfie
//
//  Created by TYG on 19/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "DropDownMenu.h"

@interface DropDownMenu ()

@end

@implementation DropDownMenu

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.menuIsHidden = YES;
        self.view.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!cell) {
        cell    =   [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    cell.textLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:15];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (indexPath.row == 0){
            cell.backgroundColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
            //cell.contentView.backgroundColor = [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
            cell.textLabel.text = @"SO funny!";
    }
    
    else if (indexPath.row == 1){
            cell.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
            //cell.contentView.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
            cell.textLabel.text = @"SO hot!";
    }
    
    else if (indexPath.row == 2){
            cell.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
            //cell.contentView.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
            cell.textLabel.text = @"SO lame!";
    }
    
    else if (indexPath.row == 3){
            cell.backgroundColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
            //cell.contentView.backgroundColor = [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
            cell.textLabel.text = @"SO weird!";
    }
    
    return cell;
}


-(UIColor*)getBackgroundColorForIndex:(int)index {
    if (index == 0) return [UIColor colorWithRed:(176/255.0) green:(208/255.0) blue:(53/255.0) alpha:1];
    if (index == 1) return [UIColor colorWithRed:(255/255.0) green:(59/255.0) blue:(119/255.0) alpha:1];
    if (index == 2) return [UIColor colorWithRed:(0/255.0) green:(173/255.0) blue:(238/255.0) alpha:1];
    if (index == 3) return [UIColor colorWithRed:(96/255.0) green:(45/255.0) blue:(144/255.0) alpha:1];
    return nil;
}

-(UIColor*)getHighlightColorForIndex:(int)index {
    if (index == 0) return [UIColor colorWithRed:(197/255.0) green:(229/255.0) blue:(62/255.0) alpha:1];
    if (index == 1) return [UIColor colorWithRed:(252/255.0) green:(96/255.0) blue:(152/255.0) alpha:1];
    if (index == 2) return [UIColor colorWithRed:(13/255.0) green:(198/255.0) blue:(255/255.0) alpha:1];
    if (index == 3) return [UIColor colorWithRed:(111/255.0) green:(58/255.0) blue:(173/255.0) alpha:1];
    return nil;
}



@end
