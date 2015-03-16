//
//  ViewController.m
//  UINavigationBarStyling
//
//  Created by Catalin (iMac) on 15/03/2015.
//  Copyright (c) 2015 corsarus. All rights reserved.
//

#import "ContainedViewController.h"

static NSArray *backgroundColors;

@interface ContainedViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *backgroundColorOption;
@property (weak, nonatomic) IBOutlet UISwitch *backgroundImageSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *integratedStatusBarSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *translucentSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *customBarButtonsSwitch;

@end

@implementation ContainedViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupOptions];
}

#pragma mark - UINavigationBar styling

- (void)setupOptions
{
    
    backgroundColors = @[[UIColor redColor],
                         [UIColor yellowColor],
                         [UIColor blueColor]];
    
    // Set the bar button image
    UINavigationItem *navigationItem = self.navigationItem;
    UIBarButtonItem *leftButtonItem = navigationItem.leftBarButtonItem;
    UIImage *menuButtonImage = [UIImage imageNamed:@"menuButton"];
    leftButtonItem.title = nil;
    leftButtonItem.image = menuButtonImage;
    
    // Turn off all options
    self.backgroundColorOption.selectedSegmentIndex = -1;
    [self.backgroundColorOption addTarget:self action:@selector(backgroundColorOptionChanged:) forControlEvents:UIControlEventValueChanged];
    self.backgroundImageSwitch.on = NO;
    self.integratedStatusBarSwitch.on = NO;
    self.translucentSwitch.on = NO;
    self.customBarButtonsSwitch.on = NO;
    
    [self.translucentSwitch addTarget:self action:@selector(backgroundColorOptionChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Add background image to the navigation bar
    [self.backgroundImageSwitch addTarget:self action:@selector(updateBackgroundImage:) forControlEvents:UIControlEventValueChanged];
    [self.integratedStatusBarSwitch addTarget:self action:@selector(updateBackgroundImage:) forControlEvents:UIControlEventValueChanged];
    
    [self.customBarButtonsSwitch addTarget:self action:@selector(updateBarButtonsTintColor:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationController setNeedsStatusBarAppearanceUpdate];

}

- (void)backgroundColorOptionChanged:(UIControl *)sender
{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    NSInteger navbarColorIndex = self.backgroundColorOption.selectedSegmentIndex;
    
    if (navbarColorIndex < 0)
        return;
    
    if (self.translucentSwitch.on) {
        // Set translucent background color
        navigationBar.barTintColor = nil;
        navigationBar.backgroundColor = backgroundColors[navbarColorIndex];
    } else {
        // Set opaque background color
        navigationBar.backgroundColor = nil;
        navigationBar.barTintColor = backgroundColors[navbarColorIndex];
    }
    
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
    
}

- (void)updateBackgroundImage:(UIControl *)sender
{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    UIImage *barBackgroundImage;
    if (self.integratedStatusBarSwitch.on)
        // The background image extends under the status bar
        barBackgroundImage = [UIImage imageNamed:@"backgroundImage64"];
    else
        // The status bar has its own background
        barBackgroundImage = [UIImage imageNamed:@"backgroundImage44"];
    
    if (self.backgroundImageSwitch.on) {
        navigationBar.translucent = NO;
        [navigationBar setBackgroundImage:barBackgroundImage forBarMetrics:UIBarMetricsDefault];
    } else {
        navigationBar.translucent = YES;
        [navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }
    
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
}

- (void)updateBarButtonsTintColor:(UIControl *)sender
{
    UINavigationItem *navigationItem = self.navigationItem;
    UIBarButtonItem *leftButtonItem = navigationItem.leftBarButtonItem;
    
    if (self.customBarButtonsSwitch.on) {
        // Display the button image as is in the artwork
        UIImage *menuButtonImage = [[UIImage imageNamed:@"menuButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        leftButtonItem.image = menuButtonImage;
    } else {
        // Display the button image using the tint color
        UIImage *menuButtonImage = [[UIImage imageNamed:@"menuButton"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
        leftButtonItem.image = menuButtonImage;
    }
    
}

#pragma mark - Status bar appearance

- (UIStatusBarStyle)preferredStatusBarStyle
{
    // Set the status bar style to maximize contrast with the background color
    
    NSInteger navbarColorIndex = self.backgroundColorOption.selectedSegmentIndex;
    
    if (navbarColorIndex < 0) {
        if (self.backgroundImageSwitch.on)
            return UIStatusBarStyleLightContent;
        else
            return UIStatusBarStyleDefault;
    }
    
    if (!self.translucentSwitch.on && navbarColorIndex != 1) {
        return UIStatusBarStyleLightContent;
    }
    
    return UIStatusBarStyleDefault;
}


@end
