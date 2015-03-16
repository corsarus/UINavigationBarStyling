//
//  ContainerNavigationControllerViewController.m
//  UINavigationBarStyling
//
//  Created by Catalin (iMac) on 15/03/2015.
//  Copyright (c) 2015 corsarus. All rights reserved.
//

#import "ContainerNavigationController.h"

@interface ContainerNavigationController ()

@end

@implementation ContainerNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

@end
