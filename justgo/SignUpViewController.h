//
//  SignUpViewController.h
//  justgo
//
//  Created by Andrew Boryk on 6/22/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>

//Sign Up Properties
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *confirmField;
@property (strong, nonatomic) IBOutlet UIButton *signupButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

//Sign Up Actions
- (IBAction)signupAction:(id)sender;
- (IBAction)backAction:(id)sender;



@end
