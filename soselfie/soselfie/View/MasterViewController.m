//
//  MasterViewController.m
//  SoSelfie
//
//  Created by TYG on 21/02/14.
//  Copyright (c) 2014 TYG. All rights reserved.
//

#import "MasterViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MasterViewController () {
    CGPoint positionAtStartOfGesture;
    float swipeMenuMax;
}

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
    }
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
  
    //generic central view
    
    self.genericCentralVIew = [[UIView alloc] init];
    
    
    //iphone 4 or 5
    
    if ([SSMacros deviceType] == SSDeviceTypeiPhone5) {
     
    self.genericCentralVIew.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    }
    else {
        
    self.genericCentralVIew.frame = CGRectMake(0, -[UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
    }
    
    self.genericCentralVIew.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.genericCentralVIew];
    [self.view addGestureRecognizer:self.panRecognizer];
    [self.genericCentralVIew addGestureRecognizer:self.tapRecognizer];
    
    //your selfies view controller
    
    self.yourSelfiesViewController = [[YourSelfiesController alloc] init];
    [self addChildViewController:self.yourSelfiesViewController];
    [self.view addSubview:self.yourSelfiesViewController.view];
    [self.genericCentralVIew addSubview:self.yourSelfiesViewController.view];
    
    //shoot view controller
    
    self.shootOneViewController = [[ShootOneViewController alloc] init];
    [self addChildViewController:self.shootOneViewController];
    [self.view addSubview:self.shootOneViewController.view];
    [self.genericCentralVIew addSubview:self.shootOneViewController.view];
    //top selfies controller
    
    self.topChartViewController = [[ViewController alloc] init];
    [self addChildViewController:self.topChartViewController];
    [self.view addSubview:self.topChartViewController.view];
    [self.genericCentralVIew addSubview:self.topChartViewController.view];
    
    //main vote view controller
    
    self.voteViewController = [[VoteViewController alloc] init];
    [self addChildViewController:self.voteViewController];
    [self.view addSubview:self.voteViewController.view];
    [self.genericCentralVIew addSubview:self.voteViewController.view];
    
    
    
    /*
    //create connect to facebook controller
    self.connectToFacebookContoller = [[ConnectToFacebookViewController alloc] init];
    [self addChildViewController:self.connectToFacebookContoller];
    [self.view addSubview:self.connectToFacebookContoller.view];
    [self.genericCentralVIew addSubview:self.connectToFacebookContoller.view];
    */
     
    
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
    
    
}

- (void) enablePanGestureRecognizer:(id)sender {
    
    NSLog (@"YESH");
    self.panRecognizer.enabled = NO;
    
}

- (void) disablePanGestureRecognizer:(id)sender {
    
    NSLog (@"JUST ENOUGH");
    
    self.panRecognizer.enabled = YES;
}

-(void)showVoteViewController:(id)sender {
    NSLog (@"1");
    
    self.voteViewController.view.alpha = 0.0;
    
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
    NSLog (@"2");
    
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
    NSLog (@"3");
    
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
    NSLog (@"4");
    
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
 
CGRect newCurrentViewControllerFrame = self.genericCentralVIew.frame;
newCurrentViewControllerFrame.origin.x = 0;
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
self.genericCentralVIew.frame = newCurrentViewControllerFrame;
                      
                     }
                     completion:nil];
    
    [self changeStatusBarColor];
    
    self.tapRecognizer.enabled = NO;
    
}

-(void)showMenuAfterButtonIsPressed:(id)sender{
    
    self.mainSwipeViewController.view.alpha = 1.0;
    
    CGRect newCurrentViewControllerFrame = self.genericCentralVIew.frame;
    
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
                         self.genericCentralVIew.frame = newCurrentViewControllerFrame;
                     }
                     completion:nil];
    [self changeStatusBarColor];
    
}


- (void)showMainMenuOnSwipe:(id)sender {
    
   
    
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    //finger position
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.genericCentralVIew];
    //NSLog(@"translated point %@", NSStringFromCGPoint(translatedPoint));
    CGRect newSwipedViewFrame = self.genericCentralVIew.frame;
    
    int coeff = 40;
    float alphaPercent = self.genericCentralVIew.frame.origin.x / swipeMenuMax;
    
    
    
    //NSLog (@"TRANSLATED POINT IS %@",NSStringFromCGPoint(translatedPoint));
    
    //tracks the direction of panning (right, left)
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan){
        positionAtStartOfGesture = newSwipedViewFrame.origin;
        
        
    }
    
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        
        self.mainSwipeViewController.view.alpha = alphaPercent;
        
        newSwipedViewFrame.origin.x = translatedPoint.x + positionAtStartOfGesture.x;
        self.genericCentralVIew.frame = newSwipedViewFrame;
        
        if(self.genericCentralVIew.frame.origin.x < 0){
        newSwipedViewFrame.origin.x = 0;
        self.genericCentralVIew.frame = newSwipedViewFrame;
        }
        
        else if(self.genericCentralVIew.frame.origin.x  > swipeMenuMax) {
        newSwipedViewFrame.origin.x = swipeMenuMax;
        self.genericCentralVIew.frame = newSwipedViewFrame;
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
            
                if(self.genericCentralVIew.frame.origin.x <= self.view.center.x){
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
                             self.genericCentralVIew.frame = newSwipedViewFrame;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
