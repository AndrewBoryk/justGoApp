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

@interface AppViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *browserBar;
@property (strong, nonatomic) NSString *appUrl;
@property (strong, nonatomic) PFObject *appInfo;
@end
