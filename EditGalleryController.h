//
//  EditGalleryController.h
//  justgo
//
//  Created by Andrew Boryk on 5/29/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCell.h"
#import <Parse/Parse.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "GalleryViewerController.h"

@interface EditGalleryController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UICollectionViewDataSource, UICollectionViewDelegate>{
    UIImagePickerController *picker1;
    UIImagePickerController *picker2;
    UIImage *image;
    NSString *videoFilePath;
}
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewer;
@property (strong, nonatomic) PFObject *gAppObject;
@property (strong, nonatomic) NSNumber *gIndexStore;

- (IBAction)addFile:(id)sender;
@end
