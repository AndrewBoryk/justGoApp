//
//  ShowPostViewController.h
//  justgo
//
//  Created by Andrew Boryk on 6/26/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ShowPostViewController : UIViewController

//Variables
@property (strong, nonatomic) PFObject *appObject;
@property (strong, nonatomic) NSMutableDictionary *postDict;
@property (strong, nonatomic) UIImage *blogPostImage;


//Properties
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *fullLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewPost;


@end
