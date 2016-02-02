//
//  MKCCommentsPostDetails.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 22/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsPostDetails.h"
#import "MKCVKPost.h"
#import "MKCVKProfile.h"
#import "VKPhotoMTL.h"

@interface MKCCommentsPostDetails ()

@property (nonatomic, strong) MKCVKPost *post;

@end

@implementation MKCCommentsPostDetails

- (instancetype)initWithVKPost:(MKCVKPost *)vkPost {
    self = [super init];
    if (self) {
        _post = vkPost;
        if (vkPost.attachments) {
            VKPhotoMTL *photo = vkPost.attachments[0];
            _postHeaderImageURL = photo.url;
            _hasAttachments = YES;
        } else {
            _hasAttachments = NO;
        }
        _postContent = vkPost.text;
        _authorName = vkPost.postOwner.name;
        _postAuthorImageURL = vkPost.postOwner.avatar;
        
        [self initialize];
    }
    return self;
}

- (void)initialize {
    RAC(self, isUserLikes) = RACObserve(self.post, isUserLikes);
    RAC(self, likesCount) = [RACObserve(self.post, likesCount) map:^id(NSNumber *newValue) {
        return [newValue stringValue];
    }];
    RAC(self, isUserReposted) = RACObserve(self.post, isUserReposted);
    RAC(self, repostsCount) = [RACObserve(self.post, repostsCount) map:^id(NSNumber *newValue) {
        return [newValue stringValue];
    }];
}

@end
