//
//  MKCCommentsPostTableViewCell.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsPostTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MKCCommentsPostTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *authorAvatar;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *postContent;

@end

@implementation MKCCommentsPostTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindData:(MKCCommentsPost *)post {
    [self.postContent setText:post.postContent];
    [self.authorName setText:post.authorName];
    [self.authorAvatar sd_setImageWithURL:post.postAuthorImageURL];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.postContent.preferredMaxLayoutWidth = self.bounds.size.width - 24;
}

@end
