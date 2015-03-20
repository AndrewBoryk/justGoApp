//
//  NewWordViewController.h
//  justgo
//
//  Created by Andrew Boryk on 1/28/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h> 

@interface NewWordViewController : UIViewController <UITextFieldDelegate, UIWebViewDelegate>

//Properties
@property (strong, nonatomic) IBOutlet UITextField *wordField;
@property (strong, nonatomic) IBOutlet UITextField *linkField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIView *disabledView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIButton *changeButton;
@property (strong, nonatomic) IBOutlet UIButton *approveButton;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

//Actions
- (IBAction)submitWord:(id)sender;
- (IBAction)hideKey:(id)sender;
- (IBAction)changeLink:(id)sender;
- (IBAction)approveLink:(id)sender;
- (IBAction)typing:(id)sender;

@end
