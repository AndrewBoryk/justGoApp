//
//  AppViewController.m
//  justgo
//
//  Created by Andrew Boryk on 3/22/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@end

@implementation AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.browserBar.text = self.appUrl;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.browserBar resignFirstResponder];
}

@end
