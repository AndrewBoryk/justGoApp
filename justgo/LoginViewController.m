//
//  LoginViewController.m
//  justgo
//
//  Created by Andrew Boryk on 6/22/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (IBAction)loginAction:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you fill out all fields!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }

    else{
        username = [username lowercaseString];
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (!error) {
                PFInstallation *installation = [PFInstallation currentInstallation];
                installation[@"user"] = user.objectId;
                [installation saveInBackground];
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
        }];
    }
}

-(IBAction)textFieldReturn:(id)sender
{
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
@end
