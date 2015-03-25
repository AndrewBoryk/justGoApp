//
//  ViewController.m
//  justgo
//
//  Created by Andrew Boryk on 1/26/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

NSMutableArray *instantObjects;
NSString *searchText;
PFObject *appObject;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    instantObjects = [[NSMutableArray alloc] init];
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.activityIndicator.hidden = 1;
    [self.activityIndicator stopAnimating];
    self.disabledView.hidden = 1;
    self.searchBar.placeholder = @"Search Here";
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.9f]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.9f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.title = @"";
    self.navigationController.navigationBar.translucent = NO;
    self.oneButton.hidden = 1;
    self.twoButton.hidden = 1;
    self.threeButton.hidden = 1;
    self.fourButton.hidden = 1;
    self.fiveButton.hidden = 1;
    self.oneButton.layer.borderWidth = 0.25f;
    self.twoButton.layer.borderWidth = 0.25f;
    self.threeButton.layer.borderWidth = 0.25f;
    self.fourButton.layer.borderWidth = 0.25f;
    self.fiveButton.layer.borderWidth = 0.25f;
    self.oneButton.layer.borderColor = [UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.5f].CGColor;
    self.twoButton.layer.borderColor = [UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.5f].CGColor;
    self.threeButton.layer.borderColor = [UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.5f].CGColor;
    self.fourButton.layer.borderColor = [UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.5f].CGColor;
    self.fiveButton.layer.borderColor = [UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.5f].CGColor;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (IBAction)searchAction:(id)sender {
    [self.searchBar resignFirstResponder];
    [self searchNow];
}

- (IBAction)typing:(id)sender {
    [instantObjects removeAllObjects];
    [self.oneButton setTitle:@"" forState:UIControlStateNormal];
    [self.twoButton setTitle:@"" forState:UIControlStateNormal];
    [self.threeButton setTitle:@"" forState:UIControlStateNormal];
    [self.fourButton setTitle:@"" forState:UIControlStateNormal];
    [self.fiveButton setTitle:@"" forState:UIControlStateNormal];
    self.activityIndicator.hidden = 0;
    [self.activityIndicator startAnimating];
    self.oneButton.hidden = 1;
    self.twoButton.hidden = 1;
    self.threeButton.hidden = 1;
    self.fourButton.hidden = 1;
    self.fiveButton.hidden = 1;
    self.searchBar.placeholder = @"Search Here";
    if (![self.searchBar.text isEqualToString:@""]) {
        [self.view setBackgroundColor:[UIColor colorWithRed:(239.0f/255.0f) green:(239.0f/255.0f) blue:(244.0f/255.0f) alpha:1.0f]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"word BEGINSWITH[cd] %@",self.searchBar.text.lowercaseString];
        PFQuery *instantQuery = [PFQuery queryWithClassName:@"SearchObjects" predicate:predicate];
        [instantQuery orderByDescending:@"sIndex"];
        [instantQuery setLimit:5];
        [instantQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            instantObjects = [objects mutableCopy];
            [self instantSetter:(int)objects.count];
        }];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.activityIndicator.hidden = 1;
        [self.activityIndicator stopAnimating];
    }
}

- (IBAction)closeKeyboard:(id)sender {
    [self.searchBar resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self searchNow];
    return YES;
}

-(void)searchNow{
    NSString *searchString = self.searchBar.text.lowercaseString;
    if ([searchString isEqualToString: @""]) {
        self.searchBar.placeholder = @"No Results";
    }
    else{
        self.activityIndicator.hidden = 0;
        [self.activityIndicator startAnimating];
        self.disabledView.hidden = 0;
        PFQuery *searchQuery = [PFQuery queryWithClassName:@"SearchObjects"];
        [searchQuery whereKey:@"word" equalTo:searchString];
        [searchQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error || objects.count == 0) {
                self.searchBar.placeholder = @"No Results";
                self.searchBar.text = @"";
            }
            else{
                [self.searchBar resignFirstResponder];
                PFObject *searchObject = [objects objectAtIndex:0];
//                NSURL *url = [NSURL URLWithString:[searchObject objectForKey:@"url"]];
                NSNumber *indexNum = [NSNumber numberWithInt:([[searchObject objectForKey:@"sIndex"] intValue] + 1)];
                [searchObject setObject:indexNum forKey:@"sIndex"];
                [searchObject saveInBackground];
                searchText = [NSString stringWithFormat:@"%@.app", self.searchBar.text.lowercaseString];
                appObject = searchObject;
                [self performSegueWithIdentifier:@"showApp" sender:self];
//                [[UIApplication sharedApplication] openURL:url];
                self.searchBar.text = @"";
            }
            self.activityIndicator.hidden = 1;
            [self.activityIndicator stopAnimating];
            self.disabledView.hidden = 1;
        }];
    }
    self.oneButton.hidden = 1;
    self.twoButton.hidden = 1;
    self.threeButton.hidden = 1;
    self.fourButton.hidden = 1;
    self.fiveButton.hidden = 1;
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)instantSetter:(int)count{
    switch (count) {
        case 0:
            self.activityIndicator.hidden = 1;
            [self.activityIndicator stopAnimating];
            break;
        case 1:
            [self instantButtonSetter:self.oneButton ind:0];
            self.activityIndicator.hidden = 1;
            [self.activityIndicator stopAnimating];
            break;
        case 2:
            [self instantButtonSetter:self.oneButton ind:0];
            [self instantButtonSetter:self.twoButton ind:1];
            self.activityIndicator.hidden = 1;
            [self.activityIndicator stopAnimating];
            break;
        case 3:
            [self instantButtonSetter:self.oneButton ind:0];
            [self instantButtonSetter:self.twoButton ind:1];
            [self instantButtonSetter:self.threeButton ind:2];
            self.activityIndicator.hidden = 1;
            [self.activityIndicator stopAnimating];
            break;
        case 4:
            [self instantButtonSetter:self.oneButton ind:0];
            [self instantButtonSetter:self.twoButton ind:1];
            [self instantButtonSetter:self.threeButton ind:2];
            [self instantButtonSetter:self.fourButton ind:3];
            self.activityIndicator.hidden = 1;
            [self.activityIndicator stopAnimating];
            break;
        case 5:
            [self instantButtonSetter:self.oneButton ind:0];
            [self instantButtonSetter:self.twoButton ind:1];
            [self instantButtonSetter:self.threeButton ind:2];
            [self instantButtonSetter:self.fourButton ind:3];
            [self instantButtonSetter:self.fiveButton ind:4];
            self.activityIndicator.hidden = 1;
            [self.activityIndicator stopAnimating];
            break;
        default:
            break;
    }
    
}

-(void)instantButtonSetter:(UIButton*)button ind:(int)i{
    NSString *word = [[instantObjects objectAtIndex:i] objectForKey:@"word"];
    NSString *firstChar = [[word substringToIndex:1] capitalizedString];
    NSString *newWord = [word stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstChar];
    [button setTitle: newWord forState:UIControlStateNormal];
    button.hidden = 0;
}

- (IBAction)oneSearch:(id)sender {
    searchText = [NSString stringWithFormat:@"%@.app", self.oneButton.titleLabel.text.lowercaseString];
    [self searcher:0];
}

- (IBAction)twoSearch:(id)sender {
    searchText = [NSString stringWithFormat:@"%@.app", self.twoButton.titleLabel.text.lowercaseString];
    [self searcher:1];
}

- (IBAction)threeSearch:(id)sender {
    searchText = [NSString stringWithFormat:@"%@.app", self.threeButton.titleLabel.text.lowercaseString];
    [self searcher:2];
}

- (IBAction)fourSearch:(id)sender {
    searchText = [NSString stringWithFormat:@"%@.app", self.fourButton.titleLabel.text.lowercaseString];
    [self searcher:3];
}

- (IBAction)fiveSearch:(id)sender {
    searchText = [NSString stringWithFormat:@"%@.app", self.fiveButton.titleLabel.text.lowercaseString];
    [self searcher:4];
}

-(void)searcher:(int)i{
    [self.searchBar resignFirstResponder];
    self.oneButton.hidden = 1;
    self.twoButton.hidden = 1;
    self.threeButton.hidden = 1;
    self.fourButton.hidden = 1;
    self.fiveButton.hidden = 1;
    PFObject *searchObject = [instantObjects objectAtIndex:i];
//    NSURL *url = [NSURL URLWithString:[searchObject objectForKey:@"url"]];
    NSNumber *indexNum = [NSNumber numberWithInt:([[searchObject objectForKey:@"sIndex"] intValue] + 1)];
    [searchObject setObject:indexNum forKey:@"sIndex"];
    [searchObject saveInBackground];
    appObject = searchObject;
    [self performSegueWithIdentifier:@"showApp" sender:self];
//    [[UIApplication sharedApplication] openURL:url];
    self.searchBar.text = @"";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showApp"]) {
        [[segue destinationViewController] setAppInfo:appObject];
        [[segue destinationViewController] setAppUrl:searchText];
    }
}
@end
