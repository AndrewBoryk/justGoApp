//
//  LoginViewController.h
//  justgo
//
//  Created by Andrew Boryk on 6/22/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

//Login Properties
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

//LoginActions
- (IBAction)loginAction:(id)sender;


@end
