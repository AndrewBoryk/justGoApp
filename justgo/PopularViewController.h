//
//  PopularViewController.h
//  justgo
//
//  Created by Andrew Boryk on 1/27/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface PopularViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

//Variables
@property NSMutableArray *popularArray;

//Properties
@property (strong, nonatomic) IBOutlet UITableView *fTable;
@property (strong, nonatomic) IBOutlet UIView *disabledView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
