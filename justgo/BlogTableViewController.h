//
//  BlogTableViewController.h
//  justgo
//
//  Created by Andrew Boryk on 6/24/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "NewBlogViewController.h"
#import "BlogPostCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ShowPostViewController.h"

@interface BlogTableViewController : UITableViewController


@property (strong, nonatomic) NSMutableArray *blogArray;
@property (strong, nonatomic) PFObject *appObject;
@property BOOL isOwned;
@end
