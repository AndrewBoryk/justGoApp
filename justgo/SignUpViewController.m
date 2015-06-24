//
//  SignUpViewController.m
//  justgo
//
//  Created by Andrew Boryk on 6/22/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (IBAction)signupAction:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    username = [username lowercaseString];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *confirm = [self.confirmField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0 || [confirm length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you fill out all fields!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    else{
        if ([username length] > 16) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Username is longer than 16 characters!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
        else if (![password isEqualToString:confirm]){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Your passwords do not match!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
        else{
            PFQuery *query = [PFUser query];
            [query whereKey:@"username" equalTo:username];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if ([objects count]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"A user with that username already exists." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alertView show];
                }
                else
                {
                    PFUser *newUser = [PFUser new];
                    newUser.username = username;
                    newUser.password = password;
                    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (!error) {
                            PFInstallation *installation = [PFInstallation currentInstallation];
                            installation[@"user"] = newUser.objectId;
                            [installation saveInBackground];
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }
                        else{
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Erorr" message:@"A problem occured when signing up" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alertView show];

                        }
                    }];
                }
            }];
        }
    }
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)textFieldReturn:(id)sender
{
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_confirmField resignFirstResponder];
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
@end
