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
}
@end
