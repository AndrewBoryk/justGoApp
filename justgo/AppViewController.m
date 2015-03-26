//
//  AppViewController.m
//  justgo
//
//  Created by Andrew Boryk on 3/22/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@end

float widgetCellSize;
@implementation AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    widgetCellSize = (self.view.frame.size.width - 60.0f)/3;
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.9f]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(27.0f/255.0f) green:(188.0f/255.0f) blue:(155.0f/255.0f) alpha:0.9f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.appUrl;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return [[self.appInfo objectForKey:@"widgets"] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WidgetCells *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 10.0f;
    cell.layer.borderWidth = 1.5f;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.widgetTitle.text = [[self.appInfo objectForKey:@"widgets"] objectAtIndex:indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(widgetCellSize, widgetCellSize);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    WidgetCells *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
