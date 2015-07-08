//
//  NewBlogViewController.h
//  justgo
//
//  Created by Andrew Boryk on 6/24/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface NewBlogViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>{
    UIImagePickerController *picker1;
    UIImagePickerController *picker2;
    UIImage *imagePost;
}

//Passed Variables
@property (strong, nonatomic) PFObject *appObject;


//Properties
@property (strong, nonatomic) IBOutlet UIImageView *blogImage;
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UITextView *fullField;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *keyboardSpacing;

//Action
- (IBAction)addImageAction:(id)sender;


@end
