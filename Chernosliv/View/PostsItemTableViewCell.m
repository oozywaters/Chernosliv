//
//  PostsItemTableViewCell.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 12.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "PostsItemTableViewCell.h"
#import "PostsItemViewModel.h"
#import "ReactiveView.h"

@interface PostsItemTableViewCell () <ReactiveView>

@end

@implementation PostsItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindViewModel:(id)viewModel {
    PostsItemViewModel *post = (PostsItemViewModel *)viewModel;
    self.textLabel.text = post.text;
}

@end
