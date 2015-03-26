//
//  ProfileViewController.m
//  justgo
//
//  Created by Andrew Boryk on 3/25/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

NSMutableArray *appArray;
@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:(246.0f/255.0f) green:(36.0f/255.0f) blue:(89.0f/255.0f) alpha:1.0f]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(246.0f/255.0f) green:(36.0f/255.0f) blue:(89.0f/255.0f) alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    PFQuery *proAppQuery = [PFQuery queryWithClassName:@"SearchObjects"];
    [proAppQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Reloaded");
            appArray = [objects mutableCopy];
            [self.appTable reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [appArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[appArray objectAtIndex:indexPath.row] objectForKey:@"word"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [[UIApplication sharedApplication] openURL:url];
}

@end
