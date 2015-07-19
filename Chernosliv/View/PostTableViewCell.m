//
//  PostTableViewCell.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "PostTableViewCell.h"
#import "VKPost.h"

@interface PostTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;


@end

@implementation PostTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindViewModel:(id)viewModel {
    VKPost *post = (VKPost *)viewModel;
//    NSString *postText = (NSString *)viewModel;
    self.textLabel.text = post.text;
}

@end
