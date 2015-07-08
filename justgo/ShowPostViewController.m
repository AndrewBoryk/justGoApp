//
//  ShowPostViewController.m
//  justgo
//
//  Created by Andrew Boryk on 6/26/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "ShowPostViewController.h"

@interface ShowPostViewController ()

@end

@implementation ShowPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = [self.postDict objectForKey:@"title"];
    self.fullLabel.layer.cornerRadius = 5.0f;
    self.fullLabel.layer.cornerRadius = 5.0f;
    self.fullLabel.text = [self.postDict objectForKey:@"full"];
    self.imageViewPost.image = self.blogPostImage;
}

@end
