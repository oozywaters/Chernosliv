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

@property (nonatomic, strong) CAKeyframeAnimation *popAnimation;

@property (nonatomic, strong) PostViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *postDate;
@property (weak, nonatomic) IBOutlet UILabel *textContent;
@property (nonatomic, strong) NSLayoutConstraint *aspectConstraint;
@property (weak, nonatomic) IBOutlet CountView *countView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, strong) NSArray *imagesArray;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;


//@property (weak, nonatomic) IBOutlet SpringButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopMagrinConstraint;

//@property (nonatomic, strong) UILabel *textContent;

@end

@implementation PostTableViewCell {
    CGFloat aspect;
}

- (void)awakeFromNib {
    // Initialization code
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
    
    self.avatar.layer.cornerRadius = 25.0;
    self.avatar.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:.2] CGColor];
    self.avatar.layer.borderWidth = 0.5;
    
    self.postImage.layer.borderWidth = 0.5;
    self.postImage.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:.2] CGColor];
    
    CGFloat force = 3.0;
    self.popAnimation = [CAKeyframeAnimation new];
    [self.popAnimation setKeyPath:@"transform.scale"];
    self.popAnimation.values = @[@0, @(0.2*force), @(-0.2*force), @(0.2*force), @0];
    self.popAnimation.keyTimes = @[@0, @0.2, @0.4, @0.6, @0.8, @1];
    self.popAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    self.popAnimation.duration = 0.7;
    self.popAnimation.additive = true;
    self.popAnimation.repeatCount = 1.0;

//    animation.duration = CFTimeInterval(duration)
//    animation.additive = true
//    animation.repeatCount = repeatCount
//    animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
//    layer.addAnimation(animation, forKey: "pop")
    
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
    
    [self.postDate setText:self.viewModel.postDate];
    [self.authorName setText:[self.viewModel.authorName uppercaseString]];
    [self.avatar sd_setImageWithURL:self.viewModel.authorImageURL];
    
//    [self.likeButton setTitle:self.viewModel.likesCount forState:UIControlStateNormal];
//    [self.repostButton setTitle:self.viewModel.repostsCount forState:UIControlStateNormal];
//    [self.commentsButton setTitle:self.viewModel.commentsCount forState:UIControlStateNormal];
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
    
    [RACObserve(self.viewModel, commentsCount) subscribeNext:^(NSString *commentsNumber) {
        [self.commentsButton setTitle:commentsNumber forState:UIControlStateNormal];
    }];
    
    [RACObserve(self.viewModel, repostsCount) subscribeNext:^(NSString *repostsNumber) {
        [self.repostButton setTitle:repostsNumber forState:UIControlStateNormal];
    }];
    
    
    [self setupTextLabelWithViewModel:self.viewModel];
    [self setupAttachmentsViewWithViewModel:self.viewModel];
    
//    UIImage *likeButtonImage = self.viewModel.isUserLikes?[UIImage imageNamed:@"heart_filled"]:[UIImage imageNamed:@"heart"];
//    [self.likeButton setImage:likeButtonImage forState:UIControlStateNormal];

//    if (self.viewModel.isUserLikes) {
//        likeButtonImage = [UIImage imageNamed:@"heart_filled"];
//    } else {
//        
//    }
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
        [self.textTopMargin setConstant:15.0];
        [self.textContent setText:viewModel.postText];
    } else {
        [self.textTopMargin setConstant:0.0];
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
        [self.imageTopMagrinConstraint setConstant:0.0];
    } else {
        [self.imageTopMagrinConstraint setConstant:15.0];
        UITapGestureRecognizer *attachmentsTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attachmentsTapped:)];
        
        CGFloat newAspect = self.viewModel.imageHeight / self.viewModel.imageWidth;
        if (aspect != newAspect) {
            aspect = newAspect;
//            NSLog(@"New constraint set");
//            self.aspectConstraint = [NSLayoutConstraint constraintWithItem:self.postImage
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.postImage
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                multiplier:aspect
//                                                                  constant:0.0];
        }
        
        [self.postImage sd_setImageWithURL:self.viewModel.imageURL];
        [self.postImage addGestureRecognizer:attachmentsTapGestureRecognizer];
        
    }
    
    if (attachCount <= 1) {
        [self.countView setHidden:YES];
    } else {
        [self.countView setHidden:NO];
        [self.countLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)attachCount]];
//        [self.countView setCount:attachCount];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
    self.textContent.preferredMaxLayoutWidth = self.bounds.size.width - 30;
}

- (void)attachmentsTapped:(UITapGestureRecognizer *)gestureRecognizer {
    self.viewModel.tappedImage = gestureRecognizer.view;
    [self.viewModel viewAttachments];
//    [self.viewModel.viewAttachments execute:self.viewModel];
}

- (IBAction)commentsButtonTapped:(UIButton *)sender {
    [sender.layer addAnimation:self.popAnimation forKey:@"pop"];
    [self.viewModel viewComments];
}

- (IBAction)likeButtonTapped:(UIButton *)sender {
    [sender.layer addAnimation:self.popAnimation forKey:@"pop"];
    [self.viewModel likePostWithResult:nil];
}

- (IBAction)repostButtonTapped:(UIButton *)sender {
    [sender.layer addAnimation:self.popAnimation forKey:@"pop"];
    [self.viewModel copyPost];
}

@end
