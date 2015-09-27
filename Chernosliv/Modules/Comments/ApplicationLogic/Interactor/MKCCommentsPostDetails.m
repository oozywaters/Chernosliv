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

@implementation MKCCommentsPostDetails

- (instancetype)initWithVKPost:(MKCVKPost *)vkPost {
    self = [super init];
    if (self) {
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
    }
    return self;
}

@end
