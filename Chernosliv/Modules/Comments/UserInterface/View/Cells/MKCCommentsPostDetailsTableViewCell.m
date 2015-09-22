//
//  MKCCommentsPostDetailsTableViewCell.mMKCCommentsPostTableViewCell
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 22/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsPostDetailsTableViewCell.h"
#import "MKCCommentsPostDetailsViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MKCCommentsPostDetailsTableViewCell ()

@property (nonatomic, strong) MKCCommentsPostDetailsViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIImageView *authorAvatar;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *postContent;

@end

@implementation MKCCommentsPostDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithModel:(id)model {
    self.viewModel = (MKCCommentsPostDetailsViewModel *)model;
    [self.postContent setText:self.viewModel.postContent];
    [self.authorName setText:self.viewModel.authorName];
    [self.authorAvatar sd_setImageWithURL:self.viewModel.authorImageURL];
}

@end
