//
//  NewWordViewController.h
//  justgo
//
//  Created by Andrew Boryk on 1/28/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h> 

@interface NewWordViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

//Properties
@property (strong, nonatomic) IBOutlet UITextField *wordField;
@property (strong, nonatomic) IBOutlet UITextField *tagField;
@property (strong, nonatomic) IBOutlet UITextView *bioField;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *keyboardSpace;

//Actions

@end
