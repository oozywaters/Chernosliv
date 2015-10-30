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
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *commentText;
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
    
//    self.commentText.font = [UIFont systemFontOfSize:16.0];
//    self.commentText.textColor = [UIColor an_colorWithHexString:@"#333333"];
//    self.commentText.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithModel:(id)model {
    MKCCommentViewModel *viewModel = (MKCCommentViewModel *)model;
    [self.authorName setText:viewModel.authorName];
    [self setupCommentContentWithText:viewModel.commentText];
    [self.avatarImage sd_setImageWithURL:viewModel.authorImageURL];
}

- (void)setupCommentContentWithText:(NSString *)text {
    NSRange stringRange = NSMakeRange(0, [text length]);
    
    NSDictionary *resultStringAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0],
                                             NSForegroundColorAttributeName: [UIColor an_colorWithHexString:@"#333333"]};
    
    NSDictionary *usernameAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0],
                                         NSForegroundColorAttributeName: [UIColor an_colorWithHexString:@"2B587A"]};
    
    
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc]
                                               initWithString:text
                                               attributes:resultStringAttributes];
//    NSMutableAttributedString *resultString = [NSMutableAttributedString stringWithString:text];
    
    NSRegularExpression *regexp = [[NSRegularExpression alloc] initWithPattern:@"\\[id([\\d]+)\\|([^\\]]+)\\]" options:NSRegularExpressionCaseInsensitive error:nil];
    [regexp enumerateMatchesInString:resultString.string options:0 range:stringRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSRange squareBracketsRange = [result rangeAtIndex:0];
        NSRange usernameRange = [result rangeAtIndex:2]; // extract user name
        NSString *username = [text substringWithRange:usernameRange];
        
        [resultString setAttributes:usernameAttributes range:squareBracketsRange];
        [resultString replaceCharactersInRange:squareBracketsRange withString:username];
    }];
    
    [self.commentText setText:resultString];
}
@end
