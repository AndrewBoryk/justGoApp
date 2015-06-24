//
//  ContactController.h
//  justgo
//
//  Created by Andrew Boryk on 5/28/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface ContactController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) NSDictionary *contactDict;
@property (strong, nonatomic) IBOutlet UIButton *phoneButton;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;
@property (strong, nonatomic) IBOutlet UIButton *webButton;

- (IBAction)phoneAction:(id)sender;
- (IBAction)emailAction:(id)sender;
- (IBAction)webAction:(id)sender;


@end
