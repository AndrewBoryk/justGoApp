//
//  PopularViewController.m
//  justgo
//
//  Created by Andrew Boryk on 1/27/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "PopularViewController.h"

@interface PopularViewController ()

@end

@implementation PopularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.popularArray = [[NSMutableArray alloc] init];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:(246.0f/255.0f) green:(36.0f/255.0f) blue:(89.0f/255.0f) alpha:1.0f]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(246.0f/255.0f) green:(36.0f/255.0f) blue:(89.0f/255.0f) alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.title = @"";
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTable:)];
    refreshButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = refreshButton;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refresh];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.popularArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *popularObject = [self.popularArray objectAtIndex:indexPath.row];
    NSString *word = [popularObject objectForKey:@"word"];
    NSString *firstChar = [[word substringToIndex:1] capitalizedString];
    NSString *newWord = [word stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstChar];
    [cell.textLabel setText: newWord];
    [cell.textLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:21]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:17]];
    if ([[popularObject objectForKey:@"isFeatured"] isEqualToString:@"Yes"]) {
        cell.textLabel.textColor = [UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:1.0f];
    }
    else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    [cell.detailTextLabel setText: [[popularObject objectForKey:@"sIndex"] stringValue]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PFObject *popularObject = [self.popularArray objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[popularObject objectForKey:@"url"]];
    NSNumber *indexNum = [NSNumber numberWithInt:([[popularObject objectForKey:@"sIndex"] intValue] + 1)];
    [popularObject setObject:indexNum forKey:@"sIndex"];
    [popularObject saveInBackground];
    [[UIApplication sharedApplication] openURL:url];
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        self.activityIndicator.hidden = 1;
        [self.activityIndicator stopAnimating];
        self.disabledView.hidden = 1;
    }
}

-(IBAction)refreshTable:(id)sender{
    [self.popularArray removeAllObjects];
    [self refresh];
}

-(void)refresh{
    self.activityIndicator.hidden = 0;
    [self.activityIndicator startAnimating];
    self.disabledView.hidden = 0;
    PFQuery *featuredQuery = [PFQuery queryWithClassName:@"SearchObjects"];
    [featuredQuery whereKey:@"isFeatured" equalTo:@"Yes"];
    [featuredQuery orderByDescending:@"sIndex"];
    [featuredQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.popularArray addObjectsFromArray:[objects mutableCopy]];
            PFQuery *popularQuery = [PFQuery queryWithClassName:@"SearchObjects"];
            [popularQuery whereKey:@"isFeatured" equalTo:@"No"];
            [popularQuery orderByDescending:@"sIndex"];
            [popularQuery setLimit:25];
            [popularQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    [self.popularArray addObjectsFromArray:[objects mutableCopy]];
                    NSLog(@"Pop: %@", self.popularArray);
                    [self.fTable reloadData];
                }
            }];
        }
    }];
}
@end
