//
//  AppViewController.m
//  justgo
//
//  Created by Andrew Boryk on 3/22/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@end

float widgetCellSize;
NSDictionary *cDict;
NSArray *galleryImgs;
NSDictionary *aDict;
NSUserDefaults *defaults;
BOOL sharing;
BOOL booking;
BOOL removingBook;
@implementation AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
//    widgetCellSize = (self.view.frame.size.width - 6.0f)/3.0f;
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.9f]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.9f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.appUrl;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return [[self.appInfo objectForKey:@"widgets"] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WidgetCells *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.layer.cornerRadius = 10.0f;
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.widgetTitle.text = [[[self.appInfo objectForKey:@"widgets"] objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize sizeOfCell;
    float cellWid;
    float cellHei;
    switch ([[self.appInfo objectForKey:@"widgets"] count]) {
        case 1:
            cellWid = (self.view.frame.size.width - 2.0f);
            cellHei = (self.view.frame.size.height - 46.0f);
            sizeOfCell = CGSizeMake(cellWid, cellHei);
            return sizeOfCell;
            break;
        case 2:
            cellWid = (self.view.frame.size.width - 2.0f);
            cellHei = (self.view.frame.size.height - 47.0f)/2.0f;
            sizeOfCell = CGSizeMake(cellWid, cellHei);
            return sizeOfCell;
            break;
        case 3:
            cellWid = (self.view.frame.size.width - 2.0f);
            cellHei = (self.view.frame.size.height - 48.0f)/3.0f;
            sizeOfCell = CGSizeMake(cellWid, cellHei);
            return sizeOfCell;
            break;
        case 4:
            if (indexPath.row == 0 || indexPath.row == 3) {
                cellWid = (self.view.frame.size.width - 2.0f);
                cellHei = (self.view.frame.size.height - 48.0f)/3.0f;
                sizeOfCell = CGSizeMake(cellWid, cellHei);
                return sizeOfCell;
            }
            else{
                cellWid = (self.view.frame.size.width - 4.0f)/2.0f;
                cellHei = (self.view.frame.size.height - 48.0f)/3.0f;
                sizeOfCell = CGSizeMake(cellWid, cellHei);
                return sizeOfCell;
            }
            break;
        case 5:
            if (indexPath.row == 0) {
                cellWid = (self.view.frame.size.width - 2.0f);
                cellHei = (self.view.frame.size.height - 48.0f)/3.0f;
                sizeOfCell = CGSizeMake(cellWid, cellHei);
                return sizeOfCell;
            }
            else{
                cellWid = (self.view.frame.size.width - 4.0f)/2.0f;
                cellHei = (self.view.frame.size.height - 48.0f)/3.0f;
                sizeOfCell = CGSizeMake(cellWid, cellHei);
                return sizeOfCell;
            }
            break;
        case 6:
            cellWid = (self.view.frame.size.width - 4.0f)/2.0f;
            cellHei = (self.view.frame.size.height - 48.0f)/3.0f;
            sizeOfCell = CGSizeMake(cellWid, cellHei);
            return sizeOfCell;
            break;
        default:
            sizeOfCell = CGSizeMake(0.0, 0.0);
            return sizeOfCell;
            break;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSString *segueString = [[[self.appInfo objectForKey:@"widgets"] objectAtIndex:indexPath.row] objectForKey:@"segue"];
    if ([segueString isEqualToString:@"contact"]) {
        cDict = [self.appInfo objectForKey:@"contact"][0] ;
        [self performSegueWithIdentifier:segueString sender:self];
    }
    if ([segueString isEqualToString:@"gallery"]) {
        galleryImgs = [self.appInfo objectForKey:@"gallery"];
        [self performSegueWithIdentifier:segueString sender:self];
    }
    if ([segueString isEqualToString:@"about"]) {
        aDict = [self.appInfo objectForKey:@"about"][0];
        [self performSegueWithIdentifier:segueString sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"contact"]) {
        [segue.destinationViewController setContactDict:cDict];
    }
    if ([segue.identifier isEqualToString:@"gallery"]) {
        [segue.destinationViewController setGalleryImages:galleryImgs];
    }
    if ([segue.identifier isEqualToString:@"about"]) {
        [segue.destinationViewController setAboutDict:aDict];
    }
}


- (IBAction)socialShare:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Visit which social page?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Facebook", @"Twitter", nil];
    
    [actionSheet showInView:self.view];
    sharing = true;
    booking = false;
}

- (IBAction)bookmarkAction:(id)sender {
    NSString *message;
    NSDictionary *bookDict = [NSDictionary dictionaryWithObjectsAndKeys:[self.appInfo objectId], @"id", [self.appInfo objectForKey:@"word"], @"word", nil];
    if ([[defaults objectForKey:@"bookmarks"] containsObject:bookDict]) {
        removingBook = YES;
        message = @"Remove bookmark";
    }
    else{
        removingBook = NO;
        message = @"Add bookmark";
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"What would you like to do?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:message, nil];
    
    [actionSheet showInView:self.view];
    booking = true;
    sharing = false;
}

#pragma mark Action Sheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (booking) {
        if (buttonIndex == 0) {
//            if ([PFUser currentUser]) {
//                PFUser *cUser = [PFUser currentUser];
//                if ([cUser objectForKey:@"bookmarks"]) {
//                    NSMutableArray *bookArray = [[cUser objectForKey:@"bookmarks"] mutableCopy];
//                    [bookArray addObject:[self.appInfo objectId]];
//                    [cUser setObject:bookArray forKey:@"bookmarks"];
//                }
//                else {
//                    NSMutableArray *bookArray = [NSMutableArray arrayWithObject:[self.appInfo objectId]];
//                    [cUser setObject:bookArray forKey:@"bookmarks"];
//                }
//                [cUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                    if (!error) {
//                        NSLog(@"Bookmarked");
//                    }
//                }];
//            }
            NSDictionary *bookDict = [NSDictionary dictionaryWithObjectsAndKeys:[self.appInfo objectId], @"id", [self.appInfo objectForKey:@"word"], @"word", nil];
            if (removingBook) {
                NSMutableArray *bookArray = [[defaults objectForKey:@"bookmarks"] mutableCopy];
                [bookArray removeObject:bookDict];
                [defaults setObject:bookArray forKey:@"bookmarks"];
                [defaults synchronize];
            }
            else{
                if ([defaults objectForKey:@"bookmarks"]) {
                    NSMutableArray *bookArray = [[defaults objectForKey:@"bookmarks"] mutableCopy];
                    [bookArray addObject:bookDict];
                    [defaults setObject:bookArray forKey:@"bookmarks"];
                    [defaults synchronize];
                }
                else{
                    NSMutableArray *bookArray = [NSMutableArray arrayWithObject:bookDict];
                    [defaults setObject:bookArray forKey:@"bookmarks"];
                    [defaults synchronize];
                }
            }
            
        }
    }
    else if (sharing){
        
    }
}

@end
