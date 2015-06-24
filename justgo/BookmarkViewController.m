//
//  BookmarkViewController.m
//  justgo
//
//  Created by Andrew Boryk on 6/23/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "BookmarkViewController.h"

@interface BookmarkViewController ()

@end

NSUserDefaults *defaults;
PFObject *sendObject;
@implementation BookmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[defaults objectForKey:@"bookmarks"] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *word = [[[defaults objectForKey:@"bookmarks"] objectAtIndex:indexPath.row] objectForKey:@"word"];
    NSString *firstChar = [[word substringToIndex:1] capitalizedString];
    NSString *newWord = [word stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstChar];
    [cell.textLabel setText: newWord];
    [cell.textLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:21]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PFQuery *query = [PFQuery queryWithClassName:@"SearchObjects"];
    [query whereKey:@"objectId" equalTo:[[[defaults objectForKey:@"bookmarks"] objectAtIndex:indexPath.row] objectForKey:@"id"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        sendObject = [objects firstObject];
        [self performSegueWithIdentifier:@"app" sender:self];
    }];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"app"]) {
        [segue.destinationViewController setAppInfo:sendObject];
    }
}

@end
