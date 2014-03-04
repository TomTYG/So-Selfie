//
//  RootOwnSelfiesViewCell.m
//  soselfie
//
//  Created by Tom van Kruijsbergen on 25/02/14.
//  Copyright (c) 2014 TYG Digital. All rights reserved.
//

#import "RootOwnSelfiesViewCell.h"
#import "SSAPI.h"

@interface RootOwnSelfiesViewCell () {
    UIImageView *imageView;
    UIButton *eraseButton;
    
    UILabel *votesFunny;
    UILabel *votesHot;
    UILabel *votesLame;
    UILabel *votesTryagain;
}

@end

@implementation RootOwnSelfiesViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 150, 150)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:imageView];
    
    float left = imageView.frame.origin.x + imageView.frame.size.width;
    float height = 40;
    
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(left, imageView.frame.origin.y + imageView.frame.size.height - height, self.frame.size.width - left, 40)];
    [b setTitle:@"Erase" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [b addTarget:self action:@selector(eraseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    eraseButton = b;
    [self addSubview:b];
    
    height = imageView.frame.origin.y;
    left += 6;
    float fontsize = 16;
    votesFunny = [[UILabel alloc] initWithFrame:CGRectMake(left, height, self.frame.size.width - left, fontsize + 12)];
    votesFunny.font = [UIFont systemFontOfSize:fontsize];
    votesFunny.textAlignment = NSTextAlignmentLeft;
    votesFunny.text = @"Funny: ";
    [self addSubview:votesFunny];
    
    height = votesFunny.frame.origin.y + votesFunny.frame.size.height;
    
    votesHot = [[UILabel alloc] initWithFrame:CGRectMake(left, height, self.frame.size.width - left, fontsize + 12)];
    votesHot.font = [UIFont systemFontOfSize:fontsize];
    votesHot.textAlignment = NSTextAlignmentLeft;
    votesHot.text = @"Hot: ";
    [self addSubview:votesHot];
    
    height = votesHot.frame.origin.y + votesHot.frame.size.height;
    
    votesLame = [[UILabel alloc] initWithFrame:CGRectMake(left, height, self.frame.size.width - left, fontsize + 12)];
    votesLame.font = [UIFont systemFontOfSize:fontsize];
    votesLame.textAlignment = NSTextAlignmentLeft;
    votesLame.text = @"Lame: ";
    [self addSubview:votesLame];
    
    height = votesLame.frame.origin.y + votesLame.frame.size.height;
    
    votesTryagain = [[UILabel alloc] initWithFrame:CGRectMake(left, height, self.frame.size.width - left, fontsize + 12)];
    votesTryagain.font = [UIFont systemFontOfSize:fontsize];
    votesTryagain.textAlignment = NSTextAlignmentLeft;
    votesTryagain.text = @"Weird: ";
    [self addSubview:votesTryagain];
    
    return self;
}

-(void)startWithData:(NSDictionary *)data {
    self.data = data;
    
    [SSAPI getImageWithImageURL:data[@"url_small"] onComplete:^(UIImage *image, NSError *error){
        if (self.data != data) return;
        if (error != nil) {
            NSLog(@"image load %@", error);
            return;
        }
        imageView.image = image;
        votesFunny.text = [NSString stringWithFormat:@"Funny: %@", data[@"votes_funny"]];
        votesHot.text = [NSString stringWithFormat:@"Hot: %@", data[@"votes_hot"]];
        votesLame.text = [NSString stringWithFormat:@"Lame: %@", data[@"votes_lame"]];
        votesTryagain.text = [NSString stringWithFormat:@"Weird: %@", data[@"votes_weird"]];
        
    }];
}

-(void)eraseButtonClicked:(id)sender {
    
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Erase selfie?" message:@"Really erase this selfie?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [v show];
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) return;
    eraseButton.enabled = NO;
    
    [SSAPI eraseSelfieID:self.data[@"id"] onComplete:^(BOOL success, NSError *possibleError){
        eraseButton.enabled = YES;
        
        if (possibleError != nil) {
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:possibleError.domain message:[possibleError description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [v show];
            return;
        }
        
        if (success == YES) {
            [self.delegate viewCellClickedEraseButton:self];
        }
    }];
}

-(void)prepareForReuse {
    eraseButton.enabled = YES;
    imageView.image = nil;
    
    votesFunny.text = @"Funny: ";
    votesHot.text = @"Hot: ";
    votesLame.text = @"Lame: ";
    votesTryagain.text = @"Weird: ";
}

@end
