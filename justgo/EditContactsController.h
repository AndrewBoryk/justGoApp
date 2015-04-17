//
//  EditContactsController.h
//  justgo
//
//  Created by Andrew Boryk on 3/26/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface EditContactsController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) PFObject *appObject;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *website;


- (IBAction)saveContacts:(id)sender;

@end
