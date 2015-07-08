//
//  BlogPostCell.h
//  justgo
//
//  Created by Andrew Boryk on 6/24/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogPostCell : UITableViewCell

//Properties
@property (strong, nonatomic) IBOutlet UIImageView *postImage;
@property (strong, nonatomic) IBOutlet UILabel *postTitle;
@property (strong, nonatomic) IBOutlet UITextView *postFull;



@end
