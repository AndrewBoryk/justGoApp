//
//  AboutViewController.m
//  justgo
//
//  Created by Andrew Boryk on 6/23/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"About";
    self.wordLabel.text = [self.aboutDict objectForKey:@"name"];
    self.tagLabel.text = [self.aboutDict objectForKey:@"tagline"];
    self.bioField.text = [self.aboutDict objectForKey:@"bio"];
}




@end
