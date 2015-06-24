//
//  WidgetEditViewController.m
//  justgo
//
//  Created by Andrew Boryk on 6/22/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "WidgetEditViewController.h"

@interface WidgetEditViewController ()

@end

@implementation WidgetEditViewController

bool contactNew;
bool galleryNew;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    for (NSDictionary *wDict in self.widgets) {
        NSString *segueString = [wDict objectForKey:@"segue"];
        [self segue:segueString word:@"contact" label:self.contactLabel switch:self.contactSwitch];
        [self segue:segueString word:@"gallery" label:self.galleryLabel switch:self.gallerySwitch];
    }
    [self.contactSwitch addTarget:self action:@selector(changeContact:) forControlEvents:UIControlEventValueChanged];
    [self.gallerySwitch addTarget:self action:@selector(changeGallery:) forControlEvents:UIControlEventValueChanged];
}

- (void)changeContact:(id)sender{
    if([sender isOn]){
        NSDictionary *cDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"contact", @"segue", @"Contact", @"title", nil];
        [self.widgets addObject:cDict];
        [self.contactLabel setTextColor:[UIColor blackColor]];
        contactNew = true;
        NSLog(@"Switch is off");
    } else{
        for (NSDictionary *wDict in self.widgets) {
            if ([[wDict objectForKey:@"segue"] isEqualToString:@"contact"]) {
                [self.widgets removeObject:wDict];
                [self.contactLabel setTextColor:[UIColor colorWithRed:85.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:1.0f]];
                NSLog(@"Switch is on");
                contactNew = false;
                break;
            }
        }
    }
}

- (void)changeGallery:(id)sender{
    if([sender isOn]){
        NSDictionary *gDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"gallery", @"segue", @"Gallery", @"title", nil];
        [self.widgets addObject:gDict];
        [self.galleryLabel setTextColor:[UIColor blackColor]];
        galleryNew = true;
    } else{
        for (NSDictionary *wDict in self.widgets) {
            if ([[wDict objectForKey:@"segue"] isEqualToString:@"gallery"]) {
                [self.widgets removeObject:wDict];
                [self.galleryLabel setTextColor:[UIColor colorWithRed:85.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:1.0f]];
                NSLog(@"Switch is on");
                galleryNew = false;
                break;
            }
        }
    }
}

-(void)segue:(NSString *)segue word:(NSString *)word label:(UILabel *)label switch:(UISwitch *)switcher{
    if ([segue isEqualToString:word]) {
        [label setTextColor:[UIColor blackColor]];
        [switcher setOn:YES];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (IBAction)contactSwitchAction:(id)sender {
    if ([self.contactSwitch isOn]) {
        [self.contactSwitch setOn:NO animated:YES];
    } else {
        [self.contactSwitch setOn:YES animated:YES];
    }
}

- (IBAction)gallerySwitchAction:(id)sender {
    if ([self.gallerySwitch isOn]) {
        [self.gallerySwitch setOn:NO animated:YES];
    } else {
        [self.gallerySwitch setOn:YES animated:YES];
    }
}


-(void)doneAction:(id)sender {
    [self.appObject setObject:self.widgets forKey:@"widgets"];
    if (contactNew && ![self.appObject objectForKey:@"contact"]) {
        NSArray *cArray = [[NSArray alloc] initWithObjects:[[NSDictionary alloc] initWithObjectsAndKeys:@"", @"phone", @"", @"email", @"", @"web", nil], nil];
       [self.appObject setObject:cArray forKey:@"contact"];
    }
    if (galleryNew && ![self.appObject objectForKey:@"gallery"]) {
        NSArray *gArray = [[NSArray alloc] init];
        [self.appObject setObject:gArray forKey:@"gallery"];
    }
    [self.appObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WidgetChanged"
                                                                object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

@end
