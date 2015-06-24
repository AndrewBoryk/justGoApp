//
//  EditAboutViewController.m
//  justgo
//
//  Created by Andrew Boryk on 6/23/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "EditAboutViewController.h"

@interface EditAboutViewController ()

@end

@implementation EditAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"About";
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(submitWord:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    [self.wordField becomeFirstResponder];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    self.wordField.text = [self.aboutDict objectForKey:@"name"];
    self.tagField.text = [self.aboutDict objectForKey:@"tagline"];
    self.bioField.text = [self.aboutDict objectForKey:@"bio"];
}

-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
    
    self.keyboardSpace.constant = keyboardFrame.size.height;
}

- (void)submitWord:(id)sender {
    NSString *title = self.wordField.text;
    NSString *tagline = self.tagField.text;
    NSString *bio = self.bioField.text;
    if (![title isEqualToString:@""] && ![tagline isEqualToString:@""] && ![bio isEqualToString:@""]) {
        if (![title isEqualToString:[self.aboutDict objectForKey:@"name"]] || ![tagline isEqualToString:[self.aboutDict objectForKey:@"tagline"]] || ![bio isEqualToString:[self.aboutDict objectForKey:@"bio"]]) {
            NSDictionary *newDict = [NSDictionary dictionaryWithObjectsAndKeys:title, @"name", tagline, @"tagline", bio, @"bio", nil];
            NSMutableArray *aArray = [NSMutableArray arrayWithObject:newDict];
            [self.appObject setObject:aArray forKey:@"about"];
            [self.appObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please fill in all fields, thank you!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}

@end
