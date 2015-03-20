//
//  NewWordViewController.m
//  justgo
//
//  Created by Andrew Boryk on 1/28/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "NewWordViewController.h"

@interface NewWordViewController ()

@end

NSString *linkString;
@implementation NewWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.disabledView.hidden = 1;
    self.activityIndicator.hidden = 1;
    [self.activityIndicator stopAnimating];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.9f]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.9f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.title = @"";
    self.navigationItem.title = @"Claim Your Word";
    self.navigationController.navigationBar.translucent = NO;
    self.webView.hidden = 1;
    self.approveButton.hidden = 1;
    self.changeButton.hidden = 1;
    self.submitButton.hidden = 0;
}


- (IBAction)submitWord:(id)sender {
    if (![self.wordField.text isEqualToString:@""] && ![self.linkField.text isEqualToString:@""]) {
        self.activityIndicator.hidden = 0;
        [self.activityIndicator startAnimating];
        PFQuery *checkQuery = [PFQuery queryWithClassName:@"SearchObjects"];
        [checkQuery whereKey:@"word" equalTo:self.wordField.text.lowercaseString];
        [checkQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects.count == 0) {
                NSString *myURLString = self.linkField.text;
                if ([myURLString hasPrefix:@"http://"] || [myURLString hasPrefix:@"https://"]) {
                    linkString = myURLString;
                } else {
                    linkString = [NSString stringWithFormat:@"http://%@",myURLString];
                }
                self.webView.hidden = 0;
                [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:linkString]]];
                self.submitButton.hidden = 1;
                self.approveButton.hidden = 0;
                self.changeButton.hidden = 0;
            }
            else{
                self.activityIndicator.hidden = 1;
                [self.activityIndicator stopAnimating];
                self.wordField.text = @"";
                self.wordField.placeholder = @"Word Already Taken";
            }
        }];
    }
}

- (IBAction)hideKey:(id)sender {
    [self.wordField resignFirstResponder];
    [self.linkField resignFirstResponder];
}

- (IBAction)changeLink:(id)sender {
    self.linkField.text = @"";
    self.webView.hidden = 1;
    self.submitButton.hidden = 0;
    self.approveButton.hidden = 1;
    self.changeButton.hidden = 1;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
}

- (IBAction)approveLink:(id)sender {
    self.disabledView.hidden = 0;
    self.activityIndicator.hidden = 0;
    [self.activityIndicator startAnimating];
    PFObject *wordObject = [PFObject objectWithClassName:@"SearchObjects"];
    [wordObject setObject:[self.wordField.text lowercaseString]  forKey:@"word"];
    [wordObject setObject:linkString  forKey:@"url"];
    [wordObject setObject:[NSNumber numberWithInt:0] forKey:@"sIndex"];
    [wordObject setObject:@"No" forKey:@"isFeatured"];
    [wordObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            NSLog(@"Error: %@", error);
        }
        self.disabledView.hidden = 1;
        self.activityIndicator.hidden = 1;
        [self.activityIndicator stopAnimating];
    }];
}

- (IBAction)typing:(id)sender {
    self.wordField.placeholder = @"Enter Desired Word Here";
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    self.activityIndicator.hidden = 0;
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.activityIndicator.hidden = 1;
    [self.activityIndicator stopAnimating];
}
@end
