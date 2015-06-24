//
//  NewWordViewController.m
//  justgo
//
//  Created by Andrew Boryk on 1/28/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "NewWordViewController.h"

@interface NewWordViewController ()

@end

@implementation NewWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Claim Your Word";
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(submitWord:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    [self.wordField becomeFirstResponder];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
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
    if (![self.wordField.text isEqualToString:@""] && ![self.tagField.text isEqualToString:@""] && ![self.bioField.text isEqualToString:@""]) {
        NSString *title = self.wordField.text;
        NSString *tagline = self.tagField.text;
        NSString *bio = self.bioField.text;
        NSDictionary *newDict = [NSDictionary dictionaryWithObjectsAndKeys:title, @"name", tagline, @"tagline", bio, @"bio", nil];
        NSMutableArray *aArray = [NSMutableArray arrayWithObject:newDict];
        NSArray *widgetArray = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"about", @"segue", @"About", @"title", nil], nil];
        PFObject *newWord = [PFObject objectWithClassName:@"SearchObjects"];
        [newWord setObject:widgetArray forKey:@"widgets"];
        [newWord setObject:aArray forKey:@"about"];
        [newWord setObject:title forKey:@"default"];
        [newWord setObject:@"n" forKey:@"active"];
        [newWord setObject:@"No" forKey:@"isFeatured"];
        [newWord setObject:[NSNumber numberWithInt:0] forKey:@"sIndex"];
        [newWord setObject:[[PFUser currentUser] objectId] forKey:@"owner"];
        [newWord saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please fill in all fields, thank you!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                  [alertView show];
    }
}


@end
