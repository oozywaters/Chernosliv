//
//  PostTableViewCell.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "PostTableViewCell.h"
#import "CountView.h"


#import <SDWebImage/UIImageView+WebCache.h>
#import "VKPhotoMTL.h"
#import <AVFoundation/AVFoundation.h>
#import "PostViewModel.h"
#import "MKCWallVC.h"


@interface PostTableViewCell ()

@property (nonatomic, strong) PostViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *textContent;
@property (nonatomic, strong) NSLayoutConstraint *aspectConstraint;
@property (weak, nonatomic) IBOutlet CountView *countView;
@property (nonatomic, strong) NSArray *imagesArray;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;


@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attachmentsImgageConstraint;

//@property (nonatomic, strong) UILabel *textContent;

@end

@implementation PostTableViewCell {
    CGFloat aspect;
}

- (void)awakeFromNib {
    // Initialization code
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
    
//    _postImage.layer.shadowColor = [UIColor grayColor].CGColor;
//    _postImage.layer.shadowOffset = CGSizeMake(0, 2);
//    _postImage.layer.shadowOpacity = 1;
//    _postImage.layer.shadowRadius = 2.0;
//    _postImage.clipsToBounds = NO;
//    _postImage.layer.borderWidth = 0.5;
//    _postImage.layer.borderColor = [UIColor grayColor].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAspectConstraint:(NSLayoutConstraint *)aspectConstraint {
    if (_aspectConstraint != nil) {
        [self.postImage removeConstraint:_aspectConstraint];
        _aspectConstraint = nil;
    }
    if (aspectConstraint != nil) {
        [self.postImage addConstraint:aspectConstraint];
        _aspectConstraint = aspectConstraint;
    }
}

- (void)updateWithModel:(id)model {
    self.viewModel = (PostViewModel *)model;
    
    [self.authorName setText:self.viewModel.authorName];
    [self.avatar sd_setImageWithURL:self.viewModel.authorImageURL];
    
    NSString *likesString = [NSString stringWithFormat:@"%d", self.viewModel.likesCount];
    NSString *commentsString = [NSString stringWithFormat:@"%d", self.viewModel.commentsCount];
    NSString *repostsString = [NSString stringWithFormat:@"%d", self.viewModel.repostsCount];
    
    [self.likeButton setTitle:likesString forState:UIControlStateNormal];
    [self.repostButton setTitle:repostsString forState:UIControlStateNormal];
    [self.commentsButton setTitle:commentsString forState:UIControlStateNormal];
    
    [self setupTextLabelWithViewModel:self.viewModel];
    [self setupAttachmentsViewWithViewModel:self.viewModel];
}

//- (void)bindViewModel:(id)viewModel {
//    self.viewModel = (PostViewModel *)viewModel;
//    
//    NSString *likesString = [NSString stringWithFormat:@"%d", self.viewModel.likesCount];
//    NSString *commentsString = [NSString stringWithFormat:@"%d", self.viewModel.commentsCount];
//    NSString *repostsString = [NSString stringWithFormat:@"%d", self.viewModel.repostsCount];
//    
//    [self.likeButton setTitle:likesString forState:UIControlStateNormal];
//    [self.repostButton setTitle:repostsString forState:UIControlStateNormal];
//    [self.commentsButton setTitle:commentsString forState:UIControlStateNormal];
//    
//    [self setupTextLabelWithViewModel:self.viewModel];
//    [self setupAttachmentsViewWithViewModel:self.viewModel];
//    
//   
//}

- (void)setupTextLabelWithViewModel:(PostViewModel *)viewModel {
    if (viewModel.postText) {
        [self.textLabelConstraint setConstant:12.0];
        [self.textContent setText:viewModel.postText];
    } else {
        [self.textLabelConstraint setConstant:0.0];
        [self.textContent setText:nil];
    }
}

- (void)setupAttachmentsViewWithViewModel:(PostViewModel *)viewModel {
    NSUInteger attachCount = self.viewModel.attachmentsCount;
    
    if (attachCount == 0) {
        if (self.aspectConstraint) {
            self.aspectConstraint = nil;
        }
        [self.postImage setImage:nil];
        [self.attachmentsImgageConstraint setConstant:0.0];
    } else {
        [self.attachmentsImgageConstraint setConstant:12.0];
        UITapGestureRecognizer *attachmentsTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attachmentsTapped:)];
        
        CGFloat newAspect = self.viewModel.imageHeight / self.viewModel.imageWidth;
//        if (aspect != newAspect) {
//            aspect = newAspect;
//            NSLog(@"New constraint set");
//            self.aspectConstraint = [NSLayoutConstraint constraintWithItem:self.postImage
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.postImage
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                multiplier:aspect
//                                                                  constant:0.0];
//        }
        
        [self.postImage sd_setImageWithURL:self.viewModel.imageURL];
        [self.postImage addGestureRecognizer:attachmentsTapGestureRecognizer];
        
    }
    
    if (attachCount <= 1) {
        [self.countView setHidden:YES];
    } else {
        [self.countView setHidden:NO];
        [self.countView setCount:attachCount];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
    self.textContent.preferredMaxLayoutWidth = self.bounds.size.width - 24;
}

- (void)attachmentsTapped:(UITapGestureRecognizer *)gestureRecognizer {
    self.viewModel.tappedImage = gestureRecognizer.view;
    [self.viewModel viewAttachments];
//    [self.viewModel.viewAttachments execute:self.viewModel];
}

- (IBAction)commentsButtonTapped:(UIButton *)sender {
    [self.viewModel viewComments];
//    [self.viewModel.viewComments execute:self.viewModel];
}
@end
