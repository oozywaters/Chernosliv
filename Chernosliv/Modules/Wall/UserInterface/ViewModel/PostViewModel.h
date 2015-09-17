//
//  PostViewModel.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 29.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVKPost.h"
#import "MKCWallModuleInterface.h"

@interface PostViewModel : NSObject

@property (nonatomic, strong, readonly) MKCVKPost *post;

@property (nonatomic, strong, readonly) NSString *postId;
@property (nonatomic, strong, readonly) NSString *postText;

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic) CGFloat imageWidth;
@property (nonatomic) CGFloat imageHeight;

@property (nonatomic) NSUInteger attachmentsCount;
@property (nonatomic, strong) RACSignal *postAttachmentTap;

@property (nonatomic) NSUInteger likesCount;
@property (nonatomic) NSUInteger commentsCount;
@property (nonatomic) NSUInteger repostsCount;

@property (nonatomic, strong) UIView *tappedImage;

@property (nonatomic, strong) id<MKCWallModuleInterface> eventHandler;

- (instancetype)initWithPost:(MKCVKPost *)post;
- (CGFloat)calculateViewHeightForWidth:(CGFloat)width;

- (void)viewAttachments;
- (void)viewComments;

@end
