//
//  GalleryController.h
//  justgo
//
//  Created by Andrew Boryk on 5/30/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCell.h"
#import <Parse/Parse.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "GalleryViewerController.h"

@interface GalleryController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>{
}
@property (strong, nonatomic) NSArray *galleryImages;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewer;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@end
