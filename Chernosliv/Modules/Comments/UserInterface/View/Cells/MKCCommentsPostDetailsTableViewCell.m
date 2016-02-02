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
@property (weak, nonatomic) IBOutlet UITextView *postContent;
@property (weak, nonatomic) IBOutlet SpringButton *likeButton;
@property (weak, nonatomic) IBOutlet SpringButton *repostButton;


@end

@implementation MKCCommentsPostDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
    
    self.authorAvatar.layer.cornerRadius = 25.0;
    self.authorAvatar.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:.2] CGColor];
    self.authorAvatar.layer.borderWidth = 0.5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithModel:(id)model {
    self.viewModel = (MKCCommentsPostDetailsViewModel *)model;
    [self.postContent setText:self.viewModel.postContent];
    [self.authorName setText:[self.viewModel.authorName uppercaseString]];
    [self.authorAvatar sd_setImageWithURL:self.viewModel.authorImageURL];
    
    [RACObserve(self.viewModel, isUserLikes) subscribeNext:^(NSNumber *isLike) {
        BOOL like = [isLike boolValue];
        UIImage *likeButtonImage;
        UIColor *likeButtonTintColor;
        if (like) {
            likeButtonTintColor = [UIColor an_colorWithHexString:@"#F76256"];
            likeButtonImage = [UIImage imageNamed:@"heart_filled"];
        } else {
            likeButtonTintColor = [UIColor an_colorWithHexString:@"#4A90E2"];
            likeButtonImage = [UIImage imageNamed:@"heart"];
        }
        [self.likeButton setImage:likeButtonImage forState:UIControlStateNormal];
        [self.likeButton setTintColor:likeButtonTintColor];
    }];
    
    [RACObserve(self.viewModel, isUserReposted) subscribeNext:^(NSNumber *isReposted) {
        BOOL reposted = [isReposted boolValue];
        UIImage *repostButtonImage;
        if (reposted) {
            repostButtonImage = [UIImage imageNamed:@"electronic_megaphone_filled"];
        } else {
            repostButtonImage = [UIImage imageNamed:@"electronic_megaphone"];
        }
        [self.repostButton setImage:repostButtonImage forState:UIControlStateNormal];
    }];
    
    [RACObserve(self.viewModel, likesCount) subscribeNext:^(NSString *likesNumber) {
        [self.likeButton setTitle:likesNumber forState:UIControlStateNormal];
    }];
    
    [RACObserve(self.viewModel, repostsCount) subscribeNext:^(NSString *repostsNumber) {
        [self.repostButton setTitle:repostsNumber forState:UIControlStateNormal];
    }];
}

- (IBAction)likeButtonTouched:(SpringButton *)sender {
    sender.animation = @"pop";
    sender.force = 3.0;
    [sender animate];
    [self.viewModel likePost];
}

- (IBAction)repostButtonTouched:(SpringButton *)sender {
    sender.animation = @"pop";
    sender.force = 3.0;
    [sender animate];
    [self.viewModel copyPost];
}

@end
