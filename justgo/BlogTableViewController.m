//
//  BlogTableViewController.m
//  justgo
//
//  Created by Andrew Boryk on 6/24/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "BlogTableViewController.h"

@interface BlogTableViewController ()

@end

NSMutableArray *imageArray;
NSMutableDictionary *postDict;
UIImage *postImagePassing;
@implementation BlogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isOwned) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPost:)];
        [self.navigationItem setRightBarButtonItem:addButton];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadBlog:)
                                                 name:@"blogUpdate"
                                               object:nil];
    imageArray = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (NSDictionary *bDict in self.blogArray) {
        PFFile *imageFile = [bDict objectForKey:@"file"];
        if ([[bDict objectForKey:@"fileType"] isEqualToString:@"image"]) {
            NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
            NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
            [imageArray addObject:[UIImage imageWithData:imageData]];
        }
        else{
            
        }
    }
    [self.tableView reloadData];
}

-(void)reloadBlog:(id)sender{
    PFQuery *reloadQuery = [PFQuery queryWithClassName:@"SearchObjects"];
    [reloadQuery whereKey:@"objectId" equalTo:self.appObject.objectId];
    [reloadQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.appObject = objects[0];
            [self.tableView reloadData];
        }
    }];
}
-(void)addPost:(id)sender {
    [self performSegueWithIdentifier:@"toPost" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toPost"]) {
        [segue.destinationViewController setAppObject:self.appObject];
    }
    if ([segue.identifier isEqualToString:@"readPost"]) {
        [segue.destinationViewController setAppObject:self.appObject];
        [segue.destinationViewController setPostDict:postDict];
        [segue.destinationViewController setBlogPostImage:postImagePassing];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogPostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.postTitle.text = [[self.blogArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.postTitle.layer.cornerRadius = 5.0f;
    cell.postFull.layer.cornerRadius = 5.0f;
    cell.postFull.text = [[self.blogArray objectAtIndex:indexPath.row] objectForKey:@"full"];
    cell.postFull.userInteractionEnabled = NO;
    cell.postImage.image = [imageArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    postDict = [[self.blogArray objectAtIndex:indexPath.row] mutableCopy];
    postImagePassing = [imageArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"readPost" sender:self];
}
@end
