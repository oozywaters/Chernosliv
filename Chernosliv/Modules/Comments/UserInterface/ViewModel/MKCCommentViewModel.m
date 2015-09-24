//
//  MKCCommentViewModel.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 23/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentViewModel.h"
#import "MKCVKComment.h"

@implementation MKCCommentViewModel

+ (instancetype)viewModelWithComment:(MKCVKComment *)comment {
    return [[self alloc] initWithModel:comment];
}

- (instancetype)initWithModel:(MKCVKComment *)comment {
    self = [super init];
    if (self) {
        _authorName = [NSString stringWithFormat:@"%@ %@", comment.author.firstName, comment.author.lastName];
        _commentText = comment.text;
        _authorImageURL = comment.author.avatar;
    }
    return self;
}

@end
