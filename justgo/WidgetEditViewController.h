//
//  WidgetEditViewController.h
//  justgo
//
//  Created by Andrew Boryk on 6/22/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "EditAppController.h"

@interface WidgetEditViewController : UITableViewController

//Passed Objects
@property (strong, nonatomic) NSMutableArray *widgets;
@property (strong, nonatomic) PFObject *appObject;

//Properties
@property (strong, nonatomic) IBOutlet UILabel *contactLabel;
@property (strong, nonatomic) IBOutlet UILabel *galleryLabel;
@property (strong, nonatomic) IBOutlet UILabel *blogLabel;
@property (strong, nonatomic) IBOutlet UISwitch *contactSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *gallerySwitch;
@property (strong, nonatomic) IBOutlet UISwitch *blogSwitch;


//Actions
- (IBAction)contactSwitchAction:(id)sender;
- (IBAction)gallerySwitchAction:(id)sender;
- (IBAction)blogSwitchAction:(id)sender;

@end
