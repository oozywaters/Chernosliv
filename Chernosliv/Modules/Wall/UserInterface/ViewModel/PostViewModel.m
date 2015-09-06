//
//  PostViewModel.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 29.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "PostViewModel.h"
#import "VKPhotoMTL.h"
//#import "AttachmentsViewModel.h"

@interface PostViewModel ()

@end

@implementation PostViewModel

- (instancetype)initWithPost:(MKCVKPost *)post {
    self = [super init];
    if (self) {
        _post = post;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _postText = self.post.text;
    
    _likesCount = self.post.likesCount;
    _commentsCount = self.post.commentsCount;
    _repostsCount = self.post.repostsCount;
    
    VKPhotoMTL *thumbnailPhoto = [self.post.attachments firstObject];
    _imageURL = thumbnailPhoto.url;
    _imageWidth = thumbnailPhoto.size.width;
    _imageHeight = thumbnailPhoto.size.height;
    
    _attachmentsCount = self.post.attachments.count;
}

- (void)showAttachments {
    [self.delegate attachmentsTappedWithModel:self.post];
}

- (void)showComments {
    [self.delegate commentsTappedWithModel:self.post];
}

@end
