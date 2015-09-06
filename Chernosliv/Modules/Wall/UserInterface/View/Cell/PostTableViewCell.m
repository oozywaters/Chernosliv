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
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PostViewModel.h"
#import "MKCWallTableViewController.h"

@interface PostTableViewCell ()

@property (nonatomic, strong) PostViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *textContent;
@property (nonatomic, strong) NSLayoutConstraint *aspectConstraint;
@property (weak, nonatomic) IBOutlet CountView *countView;
@property (nonatomic, strong) NSArray *imagesArray;


@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;



@end

@implementation PostTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
    
    _postImage.layer.shadowColor = [UIColor grayColor].CGColor;
    _postImage.layer.shadowOffset = CGSizeMake(0, 2);
    _postImage.layer.shadowOpacity = 1;
    _postImage.layer.shadowRadius = 4.0;
    _postImage.clipsToBounds = NO;
    
    
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

- (void)bindViewModel:(id)viewModel {
    self.viewModel = (PostViewModel *)viewModel;
    
    NSString *likesString = [NSString stringWithFormat:@"%lu", self.viewModel.likesCount];
    NSString *commentsString = [NSString stringWithFormat:@"%lu", self.viewModel.commentsCount];
    NSString *repostsString = [NSString stringWithFormat:@"%lu", self.viewModel.repostsCount];
    
    [self.likeButton setTitle:likesString forState:UIControlStateNormal];
    [self.repostButton setTitle:repostsString forState:UIControlStateNormal];
    [self.commentsButton setTitle:commentsString forState:UIControlStateNormal];
    
//    self.commentsButton.rac_command = [postViewModel showComments];
   
    
//    [self.commentsButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    
//    postViewModel.postAttachmentTap = [self.attachmentTapRecognizer rac_gestureSignal];

//    VKPost *post = (VKPost *)viewModel;
//    VKPhotoMTL *photo = post.attachments[0];
//
////
    NSUInteger attachCount = self.viewModel.attachmentsCount;
    if (attachCount <= 1) {
        [self.countView setHidden:YES];
    } else {
        [self.countView setHidden:NO];
        [self.countView setCount:attachCount];
    }
    
    if (attachCount > 0) {
        UITapGestureRecognizer *attachmentsTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attachmentsTapped)];
        
        CGFloat aspect = self.viewModel.imageWidth / self.viewModel.imageHeight;
        self.aspectConstraint = [NSLayoutConstraint constraintWithItem:self.postImage
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.postImage
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:aspect
                                                              constant:0.0];
        [self.postImage sd_setImageWithURL:self.viewModel.imageURL];
        [self.postImage addGestureRecognizer:attachmentsTapGestureRecognizer];
    }
    
    self.textContent.text = self.viewModel.postText;
}

- (void)attachmentsTapped {
    if ([self.delegate respondsToSelector:@selector(postTableViewCellAttachmentsTapped:)]) {
        [self.delegate postTableViewCellAttachmentsTapped:self];
        [self.viewModel showAttachments];
    }
}

- (IBAction)commentsButtonTapped:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(postTableViewCellCommentsTapped:)]) {
        [self.delegate postTableViewCellCommentsTapped:self];
        [self.viewModel showComments];
    }
}
@end
