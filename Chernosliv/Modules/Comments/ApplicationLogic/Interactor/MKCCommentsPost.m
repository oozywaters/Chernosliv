//
//  MKCCommentsPost.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 10/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsPost.h"
#import "MKCVKPost.h"
#import "MKCVKProfile.h"
#import "VKPhotoMTL.h"

@implementation MKCCommentsPost

- (instancetype)initWithVKPost:(MKCVKPost *)vkPost authorProfile:(MKCVKProfile *)authorProfile {
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
        NSString *nameString = [NSString stringWithFormat:@"%@ %@",
                                authorProfile.firstName,
                                authorProfile.lastName];
        _authorName = nameString;
        _postAuthorImageURL = authorProfile.avatar;
    }
    return self;
}

@end
