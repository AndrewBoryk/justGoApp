//
//  EditAppController.m
//  justgo
//
//  Created by Andrew Boryk on 3/26/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "EditAppController.h"

@interface EditAppController ()

@end

@implementation EditAppController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *titleName = [NSString stringWithFormat:@"%@.app", [self.appObject objectForKey:@"word"]];
    self.navigationItem.title = titleName;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self.appObject objectForKey:@"widgets"] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WidgetCells *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 10.0f;
    cell.layer.borderWidth = 1.5f;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    return cell;
}

@end
