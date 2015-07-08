//
//  AppViewController.h
//  justgo
//
//  Created by Andrew Boryk on 3/22/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "WidgetCells.h"
#import <QuartzCore/QuartzCore.h>
#import "ContactController.h"
#import "GalleryController.h"
#import "AboutViewController.h"
#import "BlogTableViewController.h"

@interface AppViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITextField *browserBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *socialButton;

- (IBAction)socialShare:(id)sender;
- (IBAction)bookmarkAction:(id)sender;


@property (strong, nonatomic) NSString *appUrl;
@property (strong, nonatomic) PFObject *appInfo;
@end
