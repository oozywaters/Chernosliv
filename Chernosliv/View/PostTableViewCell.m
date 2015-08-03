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

@interface PostTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
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
    PostViewModel *postViewModel = (PostViewModel *)viewModel;
    
//    self.commentsButton.rac_command = [postViewModel showComments];
    [self.commentsButton addTarget:postViewModel action:@selector(showAttachments) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [self.commentsButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    
//    postViewModel.postAttachmentTap = [self.attachmentTapRecognizer rac_gestureSignal];

//    VKPost *post = (VKPost *)viewModel;
//    VKPhotoMTL *photo = post.attachments[0];
//
////
    NSUInteger attachCount = postViewModel.attachmentsCount;
    if (attachCount <= 1) {
        [self.countView setHidden:YES];
    } else {
        [self.countView setHidden:NO];
        [self.countView setCount:attachCount];
    }
    
    if (attachCount > 0) {
        UITapGestureRecognizer *imageTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:postViewModel action:@selector(showAttachments)];
        CGFloat aspect = postViewModel.imageWidth / postViewModel.imageHeight;
        self.aspectConstraint = [NSLayoutConstraint constraintWithItem:self.postImage
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.postImage
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:aspect
                                                              constant:0.0];
        [self.postImage sd_setImageWithURL:postViewModel.imageURL];
        [self.postImage addGestureRecognizer:imageTapGestureRecognizer];
    }
    
    self.textContent.text = postViewModel.postText;
}

@end
