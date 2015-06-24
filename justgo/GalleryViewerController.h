//
//  GalleryViewerController.h
//  justgo
//
//  Created by Andrew Boryk on 6/5/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GalleryViewerController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSDictionary *galleryDict;
@property (strong, nonatomic) UINavigationBar *navigationBar;
@end
