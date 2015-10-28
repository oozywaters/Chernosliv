//
//  MKCCommentsTableViewCell.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 15/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsTableViewCell.h"
#import "MKCCommentViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MKCCommentsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *commentText;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@end

@implementation MKCCommentsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
    
    self.avatarImage.layer.cornerRadius = 25.0;
    self.avatarImage.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:.2] CGColor];
    self.avatarImage.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithModel:(id)model {
    MKCCommentViewModel *viewModel = (MKCCommentViewModel *)model;
    [self.authorName setText:viewModel.authorName];
    [self.commentText setText:viewModel.commentText];
    [self.avatarImage sd_setImageWithURL:viewModel.authorImageURL];
}

@end
