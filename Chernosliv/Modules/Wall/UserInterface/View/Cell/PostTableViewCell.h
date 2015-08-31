//
//  PostTableViewCell.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveView.h"

@protocol PostTableViewCellDelegate <NSObject>

- (void)postTableViewCellAttachmentsTapped:(UITableViewCell *)cell;
- (void)postTableViewCellCommentsTapped:(UITableViewCell *)cell;

@end

@interface PostTableViewCell : UITableViewCell <ReactiveView>

@property (nonatomic, weak) id<PostTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *postImage;

@end
