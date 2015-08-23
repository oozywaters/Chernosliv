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

@property (nonatomic, strong) VKPost *post;

@end

@implementation PostViewModel

- (instancetype)initWithPost:(VKPost *)post {
    self = [super init];
    if (self) {
        _post = post;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _postText = self.post.text;
    
    VKPhotoMTL *thumbnailPhoto = [self.post.attachments firstObject];
    _imageURL = thumbnailPhoto.url;
    _imageWidth = thumbnailPhoto.size.width;
    _imageHeight = thumbnailPhoto.size.height;
    
    _attachmentsCount = self.post.attachments.count;
}

- (RACCommand *)showComments {
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"Show tratata");
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}

- (void)showAttachments {
    NSLog(@"Show attachments");
    [self.delegate attachmentsTappedWithPost:self.post];
//    AttachmentsViewModel *attachmentsViewModel = [[AttachmentsViewModel alloc] initWithAttachments:self.post.attachments services:self.services];
//    [self.services pushViewModel:attachmentsViewModel];
}

@end
