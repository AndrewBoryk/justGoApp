//
//  GalleryController.m
//  justgo
//
//  Created by Andrew Boryk on 5/30/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "GalleryController.h"

@interface GalleryController ()

@end

NSMutableArray *imageArray;
NSDictionary *tempDictionary;
@implementation GalleryController

- (void)viewDidLoad {
    [super viewDidLoad];
    imageArray = [[NSMutableArray alloc] init];
//    dispatch_queue_t someQueue = dispatch_queue_create("cell background queue", NULL);
//    dispatch_async(someQueue, ^(void){
//        for (NSDictionary* fileDict in self.galleryImages) {
//            if ([[fileDict objectForKey:@"fileType"] isEqualToString:@"image"]) {
//                PFFile *imageFile = [fileDict objectForKey:@"file"];
//                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//                    UIImage *imageFinish = [UIImage imageWithData:data];
//                    [imageArray addObject:imageFinish];
//                }];
//            }
//            else if ([[fileDict objectForKey:@"fileType"] isEqualToString:@"video"]){
//                PFFile *videoFile = [fileDict objectForKey:@"file"];
//                NSURL *videoURL = [[NSURL alloc] initWithString:videoFile.url];
//                AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
//                AVAssetImageGenerator *generate1 = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
//                generate1.appliesPreferredTrackTransform = YES;
//                NSError *err = NULL;
//                CMTime time = CMTimeMake(1, 2);
//                CGImageRef oneRef = [generate1 copyCGImageAtTime:time actualTime:NULL error:&err];
//                UIImage *thumbnail = [[UIImage alloc] initWithCGImage:oneRef];
//                [imageArray addObject:thumbnail];
//            }
//        }
//        NSLog(@"Did finish %@", imageArray);
//        [self.collectionViewer reloadData];
//    });
//    imageArray = [[[[self.gAppObject objectForKey:@"widgets"] objectAtIndex:[self.gIndexStore intValue]] objectForKey:@"info"] mutableCopy];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.galleryImages count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if ([[[_galleryImages objectAtIndex:indexPath.row] objectForKey:@"fileType"] isEqualToString:@"image"]) {
        PFFile *imageFile = [[_galleryImages objectAtIndex:indexPath.row] objectForKey:@"file"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            UIImage *imageFinish = [UIImage imageWithData:data];
            cell.picture.image = imageFinish;
        }];
    }
    else if ([[[_galleryImages objectAtIndex:indexPath.row] objectForKey:@"fileType"] isEqualToString:@"video"]){
        PFFile *videoFile = [[_galleryImages objectAtIndex:indexPath.row] objectForKey:@"file"];
        NSURL *videoURL = [[NSURL alloc] initWithString:videoFile.url];
        AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        AVAssetImageGenerator *generate1 = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
        generate1.appliesPreferredTrackTransform = YES;
        NSError *err = NULL;
        CMTime time = CMTimeMake(1, 2);
        CGImageRef oneRef = [generate1 copyCGImageAtTime:time actualTime:NULL error:&err];
        UIImage *thumbnail = [[UIImage alloc] initWithCGImage:oneRef];
        cell.picture.image = thumbnail;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[[self.galleryImages objectAtIndex:indexPath.row] objectForKey:@"fileType"] isEqualToString:@"video"]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerDidExitFullscreen:) name:@"MPMoviePlayerDidExitFullscreenNotification" object:nil];
        PFFile *videoFile = [[self.galleryImages objectAtIndex:indexPath.row] objectForKey:@"file"];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
        NSString *urlString= videoFile.url;
        NSURL *fileUrl = [[NSURL alloc] initWithString:urlString];
        NSLog(@"File URL: %@", fileUrl);
        
        self.moviePlayer = [[MPMoviePlayerController alloc] init];
        self.moviePlayer.shouldAutoplay = YES;
        self.moviePlayer.controlStyle=MPMovieControlStyleFullscreen;
        [self.moviePlayer setContentURL:fileUrl];
        [self.moviePlayer.view setFrame:CGRectMake (0, 0, 320, 460)];
        [self.view addSubview:self.moviePlayer.view];
        [self.moviePlayer setFullscreen:YES animated:YES];
        [self.moviePlayer play];
        NSLog(@"Showing video");
    }
    else{
        tempDictionary = [self.galleryImages objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"showFile" sender:self];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize sizeOfCell;
    float cellWid = (self.view.frame.size.width - 6.0f)/3.0f;
    float cellHei = (self.view.frame.size.width - 6.0f)/3.0f;
    sizeOfCell = CGSizeMake(cellWid, cellHei);
    return sizeOfCell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showFile"]) {
        [segue.destinationViewController setGalleryDict:tempDictionary];
    }
}

- (void)MPMoviePlayerDidExitFullscreen:(NSNotification *)notification
{
    [self.moviePlayer stop];
    [self.moviePlayer.view removeFromSuperview];
    
    NSLog(@"DID IT EXIT");
    
    //        SavedVideoPlayerScreen *svps = (SavedVideoPlayerScreen *)[segue destinationViewController];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"MPMoviePlayerDidExitFullscreenNotification"
                                                  object:nil];
}


@end
