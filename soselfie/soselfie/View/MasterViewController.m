//
//  MasterViewController.m
//  SoSelfie
//
//  Created by TYG on 21/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "MasterViewController.h"
//#import <QuartzCore/QuartzCore.h>

@interface MasterViewController () {
    CGPoint positionAtStartOfGesture;
    float swipeMenuMax;
    UIViewController *activeViewController;
    
}

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.view.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    swipeMenuMax = 278;
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeMenuBack)];
    self.tapRecognizer.numberOfTapsRequired = 1;
    
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(showMainMenuOnSwipe:)];
    [self.panRecognizer setMinimumNumberOfTouches:1];
    [self.panRecognizer setMaximumNumberOfTouches:1];
  

    self.genericCentralView = [[UIView alloc] init];
    
    
    //iphone 4 or 5
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
     
    self.genericCentralView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    }
    else {
        
    self.genericCentralView.frame = CGRectMake(0, -[UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
    }
    
    self.genericCentralView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.genericCentralView];
    [self.view addGestureRecognizer:self.panRecognizer];
    [self.genericCentralView addGestureRecognizer:self.tapRecognizer];
    
    //your selfies view controller
    self.yourSelfiesViewController = [[YourSelfiesController alloc] init];
    self.yourSelfiesViewController.view.alpha = 0;
    [self.genericCentralView addSubview:self.yourSelfiesViewController.view];
    
    //shoot view controller
    self.shootOneViewController = [[ShootOneViewController alloc] init];
    self.shootOneViewController.view.alpha = 0;
    self.shootOneViewController.delegate = self;
    [self.genericCentralView addSubview:self.shootOneViewController.view];
    
    //top selfies controller
    self.topChartViewController = [[ViewController alloc] init];
    self.topChartViewController.view.alpha = 0;
    [self.genericCentralView addSubview:self.topChartViewController.view];
    
    //main vote view controller
    self.voteViewController = [[VoteViewController alloc] init];
    self.voteViewController.view.alpha = 0;
    [self.genericCentralView addSubview:self.voteViewController.view];
    
    
    
    
    //create connect to facebook controller
    self.connectToFacebookContoller = [[ConnectToFacebookViewController alloc] init];
    self.connectToFacebookContoller.delegate = self;
    self.connectToFacebookContoller.view.alpha = 0;
    [self.genericCentralView addSubview:self.connectToFacebookContoller.view];
    
    
    
    //main menu view controller
    
    self.mainSwipeViewController = [[MainSwipeMenuController alloc]init];
    self.mainSwipeViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:self.mainSwipeViewController];
    [self.view addSubview:self.mainSwipeViewController.view];
    [self.view sendSubviewToBack:self.mainSwipeViewController.view];
    
    //setting up swipe menu buttons
    
    [self.mainSwipeViewController.voteButton addTarget:self action:@selector(showVoteViewController:) forControlEvents:UIControlEventTouchUpInside];

    [self.mainSwipeViewController.topSelfies addTarget:self action:@selector(showTopChartViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainSwipeViewController.yourSelfiesButton addTarget:self action:@selector(showYourSelfiesViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainSwipeViewController.shootOne addTarget:self action:@selector(showShootOneViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //listining to notifications from tabBat
    static NSString *const menuButtonIsPressed = @"menuButtonIsPressed";
    static NSString *const voteButtonIsPressed = @"voteButtonIsPressed";
    static NSString *const shootButtonIsPressed = @"shootButtonIsPressed";
    static NSString *const sliderHasBeenTouched = @"sliderHasBeenTouched";
    static NSString *const sliderHasStoppedBeingTouched = @"sliderHasStoppedBeingTouched";
    
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(showMenuAfterButtonIsPressed:)
                                                 name: menuButtonIsPressed
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(showVoteViewController:)
                                                 name: voteButtonIsPressed
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(showShootOneViewController:)
                                                 name: shootButtonIsPressed
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(enablePanGestureRecognizer:)
                                                 name: sliderHasBeenTouched
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(disablePanGestureRecognizer:)
                                                 name: sliderHasStoppedBeingTouched
                                               object: nil];
    
    [self gotoNewViewController:self.connectToFacebookContoller animated:NO];
    
    
}

- (void)flipButton {
    if ( self.mainSwipeViewController.voteButton.selected ) {
        self.mainSwipeViewController.voteButton.highlighted = NO;
        self.mainSwipeViewController.voteButton.selected = NO;
    } else {
        self.mainSwipeViewController.voteButton.highlighted = YES;
        self.mainSwipeViewController.voteButton.selected = YES;
    }
}

- (void) enablePanGestureRecognizer:(id)sender {
    
    //NSLog (@"YESH");
    self.panRecognizer.enabled = NO;
    
}

- (void) disablePanGestureRecognizer:(id)sender {
    
    //NSLog (@"JUST ENOUGH");
    
    self.panRecognizer.enabled = YES;
}


-(void)gotoNewViewController:(UIViewController*)newViewController animated:(BOOL)animated {
    
    //do nothing if the new view controller is already the active view controller.
    if (activeViewController == newViewController) return;
    
    if ([newViewController respondsToSelector:@selector(becameVisible)]) {
        [newViewController performSelector:@selector(becameVisible)];
    }
    
    [self swipeMenuBack];
    
    [activeViewController.view.superview bringSubviewToFront:activeViewController.view];
    newViewController.view.alpha = 1;
    
    UIView *tempwhiteview = [[UIView alloc] initWithFrame:newViewController.view.bounds];
    tempwhiteview.alpha = 1;
    tempwhiteview.backgroundColor = [UIColor whiteColor];
    [newViewController.view addSubview:tempwhiteview];
    
    NSTimeInterval duration = animated == true ? 0.1 : 0;
    
    
    [UIView animateWithDuration:duration animations:^() {
        activeViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:0.1 options:0 animations:^() {
            tempwhiteview.alpha = 0;
        } completion:^(BOOL finished){
            [tempwhiteview removeFromSuperview];
        }];
        
    }];
    
    activeViewController = newViewController;
}


-(void)showVoteViewController:(id)sender {
    [self gotoNewViewController:self.voteViewController animated:YES];
    return;
    
    self.voteViewController.view.alpha = 0.0;
    
    self.mainSwipeViewController.voteButton.selected = YES;
    self.mainSwipeViewController.voteButton.highlighted = YES;
    
    [self swipeMenuBack];
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.voteViewController.view.alpha = 1.0;
                         self.topChartViewController.view.alpha = 0.0;
                         self.yourSelfiesViewController.view.alpha = 0.0;
                         self.shootOneViewController.view.alpha = 0.0;
                         
                     }
                     completion:nil];
    
    
}

-(void)showTopChartViewController:(id)sender {
    
    [self gotoNewViewController:self.topChartViewController animated:YES];
    return;
    
    self.mainSwipeViewController.voteButton.selected = YES;
    self.mainSwipeViewController.voteButton.highlighted = YES;
    
    self.topChartViewController.view.alpha = 0.0;
    
    [self swipeMenuBack];
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.topChartViewController.view.alpha = 1.0;
                         self.voteViewController.view.alpha = 0.0;
                         self.yourSelfiesViewController.view.alpha = 0.0;
                         self.shootOneViewController.view.alpha = 0.0;
                     }
                     completion:nil];
}

-(void)showYourSelfiesViewController:(id)sender {
    
    [self gotoNewViewController:self.yourSelfiesViewController animated:YES];
    return;
    
     self.mainSwipeViewController.yourSelfiesButton.selected = YES;
    self.mainSwipeViewController.yourSelfiesButton.highlighted = YES;
    
    self.yourSelfiesViewController.view.alpha = 0.0;
    
    [self swipeMenuBack];
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.yourSelfiesViewController.view.alpha = 1.0;
                         self.voteViewController.view.alpha = 0.0;
                         self.topChartViewController.view.alpha = 0.0;
                         self.shootOneViewController.view.alpha = 0.0;
                     }
                     completion:nil];
}

-(void)showShootOneViewController:(id)sender {
    [self gotoNewViewController:self.shootOneViewController animated:YES];
    return;
    
    self.mainSwipeViewController.shootOne.selected = YES;
    self.mainSwipeViewController.shootOne.highlighted = YES;
    
    self.shootOneViewController.view.alpha = 0.0;
    
    [self swipeMenuBack];
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.shootOneViewController.view.alpha = 1.0;
                         self.yourSelfiesViewController.view.alpha = 0.0;
                         self.voteViewController.view.alpha = 0.0;
                         self.topChartViewController.view.alpha = 0.0;
                     }
                     completion:nil];
}



- (void)swipeMenuBack {
    
    self.swipeMenuIsVisible = NO; 
 
    CGRect newCurrentViewControllerFrame = self.genericCentralView.frame;
    newCurrentViewControllerFrame.origin.x = 0;
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                        self.genericCentralView.frame = newCurrentViewControllerFrame;
                      
                     }
                     completion:nil];
    
    [self changeStatusBarColor];
    
    self.tapRecognizer.enabled = NO;
    
}

-(void)showMenuAfterButtonIsPressed:(id)sender{
    
    self.mainSwipeViewController.view.alpha = 1.0;
    
    CGRect newCurrentViewControllerFrame = self.genericCentralView.frame;
    
    if(self.swipeMenuIsVisible == NO){
        newCurrentViewControllerFrame.origin.x = swipeMenuMax;
        self.swipeMenuIsVisible = YES;
        self.tapRecognizer.enabled = YES;
    }
    else {
        newCurrentViewControllerFrame.origin.x = 0;
        self.swipeMenuIsVisible = NO;
        self.tapRecognizer.enabled = NO;
    }
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.genericCentralView.frame = newCurrentViewControllerFrame;
                     }
                     completion:nil];
    [self changeStatusBarColor];
    
}


- (void)showMainMenuOnSwipe:(id)sender {
    
    //the menu should not be active while the connect to facebook button is still showing.
    if (activeViewController == self.connectToFacebookContoller) return;
   
    
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    //finger position
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.genericCentralView];
    //NSLog(@"translated point %@", NSStringFromCGPoint(translatedPoint));
    CGRect newSwipedViewFrame = self.genericCentralView.frame;
    
    int coeff = 40;
    float alphaPercent = self.genericCentralView.frame.origin.x / swipeMenuMax;
    
    
    
    //NSLog (@"TRANSLATED POINT IS %@",NSStringFromCGPoint(translatedPoint));
    
    //tracks the direction of panning (right, left)
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan){
        positionAtStartOfGesture = newSwipedViewFrame.origin;
        
        
    }
    
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        
        self.mainSwipeViewController.view.alpha = alphaPercent;
        
        newSwipedViewFrame.origin.x = translatedPoint.x + positionAtStartOfGesture.x;
        self.genericCentralView.frame = newSwipedViewFrame;
        
        if(self.genericCentralView.frame.origin.x < 0){
        newSwipedViewFrame.origin.x = 0;
        self.genericCentralView.frame = newSwipedViewFrame;
        }
        
        else if(self.genericCentralView.frame.origin.x  > swipeMenuMax) {
        newSwipedViewFrame.origin.x = swipeMenuMax;
        self.genericCentralView.frame = newSwipedViewFrame;
        }
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        
    }
    
    if(velocity.x == 0){
        velocity.x = coeff;
    }
   
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        NSLog (@"velocity x is %f",velocity.x);
        
        
        if(velocity.x == 0){
            velocity.x = coeff;
        }
        
        //pans to the left
        
        else if (velocity.x > 0){
            
            // if central view has crossed masterview center
            
            if(translatedPoint.x >= (self.view.center.x - coeff)){
                newSwipedViewFrame.origin.x = swipeMenuMax;
                alphaPercent = 1.0;
                self.swipeMenuIsVisible = YES;
                self.tapRecognizer.enabled = YES;
                
            }
            
            //if central view has not crossed masterview center
            
            else {
                if(velocity.x > 600){
                    newSwipedViewFrame.origin.x = swipeMenuMax;
                    alphaPercent = 1.0;
                    self.swipeMenuIsVisible = YES;
                    self.tapRecognizer.enabled = YES;
                }
                else{
                    newSwipedViewFrame.origin.x = 0;
                    alphaPercent = 0.0;
                    self.swipeMenuIsVisible = NO;
                    self.tapRecognizer.enabled = NO;
                }
            }
            
        }
        
        //pans to the right
        
        else {
                // if central view has crossed masterview center
            
                if(self.genericCentralView.frame.origin.x <= self.view.center.x){
                        newSwipedViewFrame.origin.x = 0;
                        alphaPercent = 0.0;
                        self.swipeMenuIsVisible = NO;
                        self.tapRecognizer.enabled = NO;
                }
            
                // if central view has not crossed masterview center
            
                else{
                    if (velocity.x < -600){
                        newSwipedViewFrame.origin.x = 0;
                        alphaPercent = 0.0;
                        self.swipeMenuIsVisible = NO;
                        self.tapRecognizer.enabled = NO;
                    }
                    else {
                        newSwipedViewFrame.origin.x = swipeMenuMax;
                        alphaPercent = 1.0;
                        self.swipeMenuIsVisible = YES;
                        self.tapRecognizer.enabled = YES;
                    }
                
            }
          
        }
        
        [UIView animateWithDuration:0.4
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.mainSwipeViewController.view.alpha = alphaPercent;
                             self.genericCentralView.frame = newSwipedViewFrame;
                         }
                         completion:nil];
        
         [self changeStatusBarColor];
    }
    
   
    
}


-(void)changeStatusBarColor {
    if (self.swipeMenuIsVisible == YES){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    else {
         [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    
}



#pragma mark - CONNECT TO FACEBOOK DELEGATE

-(void)connectToFacebookControllerLoginSuccessful:(ConnectToFacebookViewController *)viewcontroller wasUserInitiated:(BOOL)userInitiated {
    
    //consider whether you want to animate based on the login call was made by the app instead of by the user.
    [self gotoNewViewController:self.voteViewController animated:YES];
    
    //[self.voteViewController.mainVoteCollectionView reloadData];
}

#pragma mark - SHOOT ONE DELEGATE

-(void)shootOneViewControllerCameraSuccesfull:(ShootOneViewController *)viewcontroller {
    [self gotoNewViewController:self.yourSelfiesViewController animated:YES];
}


@end
