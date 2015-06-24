//
//  ContactController.m
//  justgo
//
//  Created by Andrew Boryk on 5/28/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "ContactController.h"

@interface ContactController ()

@end

@implementation ContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phoneButton setTitle: [self.contactDict objectForKey:@"phone"]forState:UIControlStateNormal];
    [self.emailButton setTitle: [self.contactDict objectForKey:@"email"]forState:UIControlStateNormal];
    [self.webButton setTitle: [self.contactDict objectForKey:@"web"]forState:UIControlStateNormal];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (IBAction)phoneAction:(id)sender {
    if ([self.contactDict objectForKey:@"phone"]) {
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",[self.contactDict objectForKey:@"phone"]]];
        
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        } else
        {
            UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [calert show];
        }
    }
}

- (IBAction)emailAction:(id)sender {
    if ([self.contactDict objectForKey:@"email"]) {
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            NSArray *toRecipients = [NSArray arrayWithObjects:[self.contactDict objectForKey:@"email"], nil];
            [controller setSubject:@""];
            [controller setToRecipients:toRecipients];
            [controller setMessageBody:@"" isHTML:NO];
            if (controller) {
                [self presentViewController:controller animated:YES completion:nil];
            }
            else
            {
                NSLog(@"Error");
            }
        }
        else
        {
            UIAlertView* message = [[UIAlertView alloc]
                                    initWithTitle: @"Sorry" message: [NSString stringWithFormat:@"This device does not support sending emails. Please contact us at: %@", [self.contactDict objectForKey:@"email"]] delegate: self
                                    cancelButtonTitle: @"Okay" otherButtonTitles: nil];
            [message show];
        }
    }
}

- (IBAction)webAction:(id)sender {
    if ([self.contactDict objectForKey:@"web"]) {
        NSURL *url = [NSURL URLWithString:[self.contactDict objectForKey:@"web"]];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
