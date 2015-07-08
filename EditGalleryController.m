//
//  EditGalleryController.m
//  justgo
//
//  Created by Andrew Boryk on 5/29/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "EditGalleryController.h"

@interface EditGalleryController ()

@end

NSMutableArray *galleryImages;
NSDictionary *tempDictionary;
BOOL deleting;
int removeIndex;
@implementation EditGalleryController

- (void)viewDidLoad {
    [super viewDidLoad];
    galleryImages = [[self.gAppObject objectForKey:@"gallery"] mutableCopy];
    self.navigationController.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(addFile:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    deleting = false;
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(addFile:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)addFile:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"What would you like to do?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Remove Photos"
                                                    otherButtonTitles:@"Take Photo", @"Choose from Library", nil];
    
    [actionSheet showInView:self.view];
}

-(void)doneEdit:(id)sender{
    self.navigationController.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(addFile:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    deleting = false;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSLog(@"Index = %ld - Title = %@", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    if (deleting) {
        if (buttonIndex == actionSheet.destructiveButtonIndex) {
            [galleryImages removeObjectAtIndex:removeIndex];
            [self.gAppObject setObject:galleryImages forKey:@"gallery"];
            [self.gAppObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"Changed");
                    [self.collectionViewer reloadData];
                }
            }];
            
        }
    }
    else {
        if (buttonIndex == actionSheet.destructiveButtonIndex){
            self.navigationController.navigationItem.rightBarButtonItem = nil;
            UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEdit:)];
            self.navigationItem.rightBarButtonItem = barButton;
            deleting = true;
        }
        else if (buttonIndex == 1) {
            picker1 = [[UIImagePickerController alloc] init];
            picker1.delegate = self;
            picker1.editing = YES;
            [picker1 setSourceType:UIImagePickerControllerSourceTypeCamera];
            picker1.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker1.sourceType];
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
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    else{
        videoFilePath = (__bridge NSString *)([[info objectForKey:UIImagePickerControllerMediaURL] path]);
    }
    NSData *fileData;
    NSString *fileName;
    NSString *fileType;
    if (image != nil)
    {
        NSLog(@"Reached Next");
        fileData = UIImageJPEGRepresentation(image, 0.9f);
        fileName = @"image.jpeg";
        fileType = @"image";
    }
    else{
        fileData = [NSData dataWithContentsOfFile:videoFilePath];
        fileName = @"video.mov";
        fileType = @"video";
    }
    PFFile *file = [PFFile fileWithName:fileName data:fileData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSDictionary *fileDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:fileType, @"fileType", file, @"file", nil];
        [galleryImages addObject:fileDictionary];
        [self.gAppObject setObject:galleryImages forKey:@"gallery"];
        [self.collectionViewer reloadData];
        [self.gAppObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"Sent to back");
            }
        }];
    }];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [galleryImages count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if ([[[galleryImages objectAtIndex:indexPath.row] objectForKey:@"fileType"] isEqualToString:@"image"]) {
        PFFile *imageFile = [[galleryImages objectAtIndex:indexPath.row] objectForKey:@"file"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            UIImage *imageFinish = [UIImage imageWithData:data];
            cell.picture.image = imageFinish;
        }];
    }
    else if ([[[galleryImages objectAtIndex:indexPath.row] objectForKey:@"fileType"] isEqualToString:@"video"]){
        PFFile *videoFile = [[galleryImages objectAtIndex:indexPath.row] objectForKey:@"file"];
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
    if (deleting) {
        removeIndex = (int)indexPath.row;
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Would you like to remove this item?"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:@"Yes"
                                                        otherButtonTitles: nil];
        
        [actionSheet showInView:self.view];
    }
    else{
        if ([[[galleryImages objectAtIndex:indexPath.row] objectForKey:@"fileType"] isEqualToString:@"video"]) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerDidExitFullscreen:) name:@"MPMoviePlayerDidExitFullscreenNotification" object:nil];
            PFFile *videoFile = [[galleryImages objectAtIndex:indexPath.row] objectForKey:@"file"];
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
            tempDictionary = [galleryImages objectAtIndex:indexPath.row];
            [self performSegueWithIdentifier:@"showFile" sender:self];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showFile"]) {
        [segue.destinationViewController setGalleryDict:tempDictionary];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize sizeOfCell;
    float cellWid = (self.view.frame.size.width - 6.0f)/3.0f;
    float cellHei = (self.view.frame.size.width - 6.0f)/3.0f;
    sizeOfCell = CGSizeMake(cellWid, cellHei);
    return sizeOfCell;
}

-(UIImage *)resizeImage:(UIImage *)imaged toWidth:(float)width andHeight:(float)height
{
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRectangle = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(newSize);
    [imaged drawInRect:newRectangle];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
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
