//
//  GalleryViewerController.m
//  justgo
//
//  Created by Andrew Boryk on 6/5/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "GalleryViewerController.h"

@interface GalleryViewerController ()

@end

@implementation GalleryViewerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    PFFile *imageFile = [self.galleryDict objectForKey:@"file"];
    NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
    self.imageView.image = [UIImage imageWithData:imageData];
}


@end
