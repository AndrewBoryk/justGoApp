//
//  EditAppController.h
//  justgo
//
//  Created by Andrew Boryk on 3/26/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "WidgetCells.h"
#import "EditContactsController.h"
#import "EditGalleryController.h"
#import "WidgetEditViewController.h"
#import "EditAboutViewController.h"

@interface EditAppController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) PFObject *appObject;


@end
