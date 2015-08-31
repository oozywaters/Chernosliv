//
//  PostViewModel.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 29.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "VKPost.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol PostViewModelDelegate <NSObject>

- (void)attachmentsTappedWithModel:(VKPost *)post;
- (void)commentsTappedWithModel:(VKPost *)post;

@end


@interface PostViewModel : NSObject

@property (nonatomic, strong, readonly) VKPost *post;

@property (nonatomic, strong) NSString *postText;

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic) CGFloat imageWidth;
@property (nonatomic) CGFloat imageHeight;

@property (nonatomic) NSUInteger attachmentsCount;
@property (nonatomic, strong) RACSignal *postAttachmentTap;

@property (nonatomic, weak) id<PostViewModelDelegate> delegate;

- (instancetype)initWithPost:(VKPost *)post;

//- (RACCommand *)showComments;

- (void)showAttachments;
- (void)showComments;

@end
