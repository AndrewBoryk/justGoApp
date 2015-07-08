//
//  EditAppController.m
//  justgo
//
//  Created by Andrew Boryk on 3/26/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "EditAppController.h"

@interface EditAppController ()

@end

NSInteger indexStore;
@implementation EditAppController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable:)
                                                 name:@"WidgetChanged"
                                               object:nil];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
    [self.navigationItem setRightBarButtonItem:editButton];
    NSString *titleName = [self.appObject objectForKey:@"word"];
    NSString *firstChar = [[titleName substringToIndex:1] capitalizedString];
    NSString *newWord = [titleName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstChar];
    self.navigationItem.title = newWord;
//    NSDictionary *aDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"about", @"segue", @"About", @"title", nil];
//    NSDictionary *cDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"contact", @"segue", @"Contact", @"title", nil];
//    NSDictionary *gDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"gallery", @"segue", @"Contact", @"title", nil];
//    NSArray *aArray = [[NSArray alloc] initWithObjects:[[NSDictionary alloc] initWithObjectsAndKeys:@"", @"name", @"", @"tagline", @"", @"bio", nil], nil];
//    NSArray *cArray = [[NSArray alloc] initWithObjects:[[NSDictionary alloc] initWithObjectsAndKeys:@"3476420638", @"phone", @"andrewcboryk@gmail.com", @"email", @"http://www.forword.nyc", @"web", nil], nil];
//    NSMutableArray *gArray = [[NSMutableArray alloc] init];
//    NSArray *widgetArray = [[NSArray alloc] initWithObjects:aDict, cDict, gDict, nil];
//    [self.appObject setObject:widgetArray forKey:@"widgets"];
//    [self.appObject setObject:aArray forKey:@"about"];
//    [self.appObject setObject:cArray forKey:@"contact"];
//    [self.appObject setObject:gArray forKey:@"gallery"];
//    [self.appObject saveInBackground];
    [self.collectionView reloadData];
}


- (void)reloadTable:(NSNotification *)notif {
    PFQuery *reloadQuery = [PFQuery queryWithClassName:@"SearchObjects"];
    [reloadQuery whereKey:@"objectId" equalTo:self.appObject.objectId];
    [reloadQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.appObject = objects[0];
            [self.collectionView reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self.appObject objectForKey:@"widgets"] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WidgetCells *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.layer.cornerRadius = 10.0f;
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.widgetTitle.text = [[[self.appObject objectForKey:@"widgets"] objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    indexStore = indexPath.row;
    NSString *segueString = [[[self.appObject objectForKey:@"widgets"] objectAtIndex:indexPath.row] objectForKey:@"segue"];
    if ([segueString isEqualToString:@"contact"]) {
        [self performSegueWithIdentifier:@"contact" sender:self];
    }
    else if ([segueString isEqualToString:@"gallery"]) {
        [self performSegueWithIdentifier:@"gallery" sender:self];
    }
    else if ([segueString isEqualToString:@"about"]) {
        [self performSegueWithIdentifier:@"about" sender:self];
    }
    else if ([segueString isEqualToString:@"blog"]) {
        [self performSegueWithIdentifier:@"blog" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"contact"]) {
        [segue.destinationViewController setContactDictionary:[self.appObject objectForKey:@"contact"][0]];
        [segue.destinationViewController setAppObject:self.appObject];
        [segue.destinationViewController setIndexStore:[NSNumber numberWithInteger:indexStore]];
    }
    else if ([segue.identifier isEqualToString:@"gallery"]) {
        [segue.destinationViewController setGAppObject:self.appObject];
        [segue.destinationViewController setGIndexStore:[NSNumber numberWithInteger:indexStore]];
    }
    else if ([segue.identifier isEqualToString:@"editWidgets"]) {
        [segue.destinationViewController setWidgets:[[self.appObject objectForKey:@"widgets"] mutableCopy]];
        [segue.destinationViewController setAppObject:self.appObject];
    }
    else if ([segue.identifier isEqualToString:@"about"]) {
        [segue.destinationViewController setAppObject:self.appObject];
        [segue.destinationViewController setAboutDict:[self.appObject objectForKey:@"about"][0]];
    }
    else if ([segue.identifier isEqualToString:@"blog"]) {
        [segue.destinationViewController setIsOwned:YES];
        [segue.destinationViewController setAppObject:self.appObject];
        [segue.destinationViewController setBlogArray:[[self.appObject objectForKey:@"blog"] mutableCopy]];
         }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize sizeOfCell;
    float cellWid;
    float cellHei;
    switch ([[self.appObject objectForKey:@"widgets"] count]) {
        case 1:
            cellWid = (self.view.frame.size.width - 2.0f);
            cellHei = (self.view.frame.size.height - 2.0f);
            sizeOfCell = CGSizeMake(cellWid, cellHei);
            return sizeOfCell;
            break;
        case 2:
            cellWid = (self.view.frame.size.width - 2.0f);
            cellHei = (self.view.frame.size.height - 3.0f)/2.0f;
            sizeOfCell = CGSizeMake(cellWid, cellHei);
            return sizeOfCell;
            break;
        case 3:
            cellWid = (self.view.frame.size.width - 2.0f);
            cellHei = (self.view.frame.size.height - 4.0f)/3.0f;
            sizeOfCell = CGSizeMake(cellWid, cellHei);
            return sizeOfCell;
            break;
        case 4:
            if (indexPath.row == 0 || indexPath.row == 3) {
                cellWid = (self.view.frame.size.width - 2.0f);
                cellHei = (self.view.frame.size.height - 4.0f)/3.0f;
                sizeOfCell = CGSizeMake(cellWid, cellHei);
                return sizeOfCell;
            }
            else{
                cellWid = (self.view.frame.size.width - 4.0f)/2.0f;
                cellHei = (self.view.frame.size.height - 4.0f)/3.0f;
                sizeOfCell = CGSizeMake(cellWid, cellHei);
                return sizeOfCell;
            }
            break;
        case 5:
            if (indexPath.row == 0) {
                cellWid = (self.view.frame.size.width - 2.0f);
                cellHei = (self.view.frame.size.height - 4.0f)/3.0f;
                sizeOfCell = CGSizeMake(cellWid, cellHei);
                return sizeOfCell;
            }
            else{
                cellWid = (self.view.frame.size.width - 4.0f)/2.0f;
                cellHei = (self.view.frame.size.height - 4.0f)/3.0f;
                sizeOfCell = CGSizeMake(cellWid, cellHei);
                return sizeOfCell;
            }
            break;
        case 6:
            cellWid = (self.view.frame.size.width - 4.0f)/2.0f;
            cellHei = (self.view.frame.size.height - 6.0f)/3.0f;
            sizeOfCell = CGSizeMake(cellWid, cellHei);
            return sizeOfCell;
            break;
        default:
            sizeOfCell = CGSizeMake(0.0, 0.0);
            return sizeOfCell;
            break;
    }
}

-(void)editAction:(id)sender{
    [self performSegueWithIdentifier:@"editWidgets" sender:self];
}

@end
