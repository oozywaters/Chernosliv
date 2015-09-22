//
//  MKCCommentsPostDetailsViewModel.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 22/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsPostDetailsViewModel.h"
#import "MKCCommentsPostDetails.h"

@implementation MKCCommentsPostDetailsViewModel

+ (MKCCommentsPostDetailsViewModel *)viewModelWithPostDetails:(MKCCommentsPostDetails *)postDetails {
    return [[self alloc] initWithModel:postDetails];
}

- (instancetype)initWithModel:(MKCCommentsPostDetails *)postDetails {
    self = [super init];
    if (self) {
        _authorName = postDetails.authorName;
        _authorImageURL = postDetails.postAuthorImageURL;
        _postContent = postDetails.postContent;
    }
    return self;
}

@end
