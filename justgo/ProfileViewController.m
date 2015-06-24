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
PFObject *sendObject;
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
    [proAppQuery orderByDescending:@"updatedAt"];
    [proAppQuery whereKey:@"owner" equalTo:[[PFUser currentUser] objectId]];
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
    PFObject *popObject = [appArray objectAtIndex:indexPath.row];
    NSString *word = [popObject objectForKey:@"default"];
    NSString *firstChar = [[word substringToIndex:1] capitalizedString];
    NSString *newWord = [word stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstChar];
    [cell.textLabel setText: newWord];
    [cell.textLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:21]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    sendObject = [appArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"app" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"app"]) {
        [segue.destinationViewController setAppObject:sendObject];
    }
}

@end
