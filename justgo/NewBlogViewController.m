//
//  NewBlogViewController.m
//  justgo
//
//  Created by Andrew Boryk on 6/24/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "NewBlogViewController.h"

@interface NewBlogViewController ()

@end

@implementation NewBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardOffScreen:) name:UIKeyboardDidHideNotification object:nil];
}


-(void)doneAction:(id)sender {
    UIImage *image = self.blogImage.image;
    NSString *title = self.titleField.text;
    NSString *full = self.fullField.text;
    if (![title isEqualToString:@""] && image && ![full isEqualToString:@""]) {
        NSData *fileData;
        NSString *fileName;
        NSString *fileType;
        fileName = @"image.jpeg";
        fileType = @"image";
        fileData = UIImageJPEGRepresentation(image, 0.9f);
        PFFile *file = [PFFile fileWithName:fileName data:fileData];
        NSDictionary *newDict = [NSDictionary dictionaryWithObjectsAndKeys:title, @"title", file, @"file", full, @"full", fileType, @"fileType", nil];
        NSMutableArray *aArray = [[self.appObject objectForKey:@"blog"] mutableCopy];
        [aArray addObject:newDict];
        [self.appObject setObject:aArray forKey:@"blog"];
        [self.appObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self.navigationController popViewControllerAnimated:YES];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"blogUpdate"
//                                                                    object:nil];
            }
        }];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please fill in all fields, thank you!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}


- (IBAction)addImageAction:(id)sender {
    if (self.blogImage.image) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"What would you like to do?"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:@"Remove Photo"
                                                        otherButtonTitles:@"Take Photo", @"Choose from Library", nil];
        
        [actionSheet showInView:self.view];
    }
    else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"What would you like to do?"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take Photo", @"Choose from Library", nil];
        
        [actionSheet showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.blogImage.image) {
        if (buttonIndex == actionSheet.destructiveButtonIndex){
            self.blogImage.image = nil;
            self.addButton.hidden = false;
        }
        else if (buttonIndex == 1) {
            picker1 = [[UIImagePickerController alloc] init];
            picker1.delegate = self;
            picker1.editing = YES;
            [picker1 setSourceType:UIImagePickerControllerSourceTypeCamera];
            picker1.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
            [self presentViewController:picker1 animated:YES completion:NULL];
        }
        else if (buttonIndex == 2){
            picker2 = [[UIImagePickerController alloc] init];
            picker2.delegate = self;
            picker2.editing = YES;
            [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            picker2.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker2.sourceType];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
            [self presentViewController:picker2 animated:YES completion:NULL];
        }
    }
    else{
        if (buttonIndex == 0) {
            picker1 = [[UIImagePickerController alloc] init];
            picker1.delegate = self;
            picker1.editing = YES;
            [picker1 setSourceType:UIImagePickerControllerSourceTypeCamera];
            picker1.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
            [self presentViewController:picker1 animated:YES completion:NULL];
        }
        else if (buttonIndex == 1){
            picker2 = [[UIImagePickerController alloc] init];
            picker2.delegate = self;
            picker2.editing = YES;
            [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            picker2.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, kUTTypeMovie, nil];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
            [self presentViewController:picker2 animated:YES completion:NULL];
        }
    }
}

-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
    
    self.keyboardSpacing.constant = keyboardFrame.size.height;
}

-(void)keyboardOffScreen:(NSNotification *)notification
{
    self.keyboardSpacing.constant = 0.0f;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark Image Picker Methods
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        imagePost = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    self.blogImage.image = imagePost;
    self.addButton.hidden = true;
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
