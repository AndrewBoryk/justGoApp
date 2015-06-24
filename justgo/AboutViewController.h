//
//  AboutViewController.h
//  justgo
//
//  Created by Andrew Boryk on 6/23/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AboutViewController : UIViewController

//Properties
@property (strong, nonatomic) IBOutlet UILabel *wordLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagLabel;
@property (strong, nonatomic) IBOutlet UITextView *bioField;
@property (strong, nonatomic) NSDictionary *aboutDict;

//Actions

@end
