//
//  ViewController.h
//  justgo
//
//  Created by Andrew Boryk on 1/26/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "AppViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

//Variables
@property NSDictionary *searchDictionary;

//Properties
@property (strong, nonatomic) IBOutlet UITextField *searchBar;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIView *disabledView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *profileButton;

//Actions
- (IBAction)searchAction:(id)sender;
- (IBAction)typing:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)profileAction:(id)sender;

//SearchButtons
@property (strong, nonatomic) IBOutlet UIButton *oneButton;
@property (strong, nonatomic) IBOutlet UIButton *twoButton;
@property (strong, nonatomic) IBOutlet UIButton *threeButton;
@property (strong, nonatomic) IBOutlet UIButton *fourButton;
@property (strong, nonatomic) IBOutlet UIButton *fiveButton;

//SearchButtonActions

- (IBAction)oneSearch:(id)sender;
- (IBAction)twoSearch:(id)sender;
- (IBAction)threeSearch:(id)sender;
- (IBAction)fourSearch:(id)sender;
- (IBAction)fiveSearch:(id)sender;

@end

