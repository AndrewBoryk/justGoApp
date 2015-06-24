//
//  EditContactsController.m
//  justgo
//
//  Created by Andrew Boryk on 3/26/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "EditContactsController.h"

@interface EditContactsController ()

@end

@implementation EditContactsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneNumber.text = [self.contactDictionary objectForKey:@"phone"];
    self.email.text = [self.contactDictionary objectForKey:@"email"];
    self.website.text = [self.contactDictionary objectForKey:@"web"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)saveContacts:(id)sender {
    self.contactDictionary = [self.contactDictionary mutableCopy];
    [self.contactDictionary setObject:self.phoneNumber.text forKey:@"phone"];
    [self.contactDictionary setObject:self.email.text forKey:@"email"];
    [self.contactDictionary setObject:self.website.text forKey:@"web"];
    [[self.appObject objectForKey:@"contact"] setObject:self.contactDictionary atIndex:0];
    [self.appObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Saved");
        }
    }];
}

@end
