//
//  MKCCommentsPostDetailsViewModel.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 22/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsPostDetailsViewModel.h"
#import "MKCCommentsPostDetails.h"

@interface MKCCommentsPostDetailsViewModel ()

@property (nonatomic, strong) MKCCommentsPostDetails *postDetails;

@end

@implementation MKCCommentsPostDetailsViewModel

+ (instancetype)viewModelWithPostDetails:(MKCCommentsPostDetails *)postDetails {
    return [[self alloc] initWithModel:postDetails];
}

- (instancetype)initWithModel:(MKCCommentsPostDetails *)postDetails {
    self = [super init];
    if (self) {
        _postDetails = postDetails;
        _authorName = postDetails.authorName;
        _authorImageURL = postDetails.postAuthorImageURL;
        _postContent = postDetails.postContent;
        [self initialize];
//        RAC(self, isUserLikes) = RACObserve(postDetails, isUserLikes);
        
    }
    return self;
}

- (void)initialize {
    RAC(self, isUserLikes) = RACObserve(self.postDetails, isUserLikes);
    RAC(self, likesCount) = RACObserve(self.postDetails, likesCount);
    RAC(self, isUserReposted) = RACObserve(self.postDetails, isUserReposted);
    RAC(self, repostsCount) = RACObserve(self.postDetails, repostsCount);
}



- (void)likePost {
    [self.eventHandler likePost];
}

- (void)copyPost {
    [self.eventHandler copyPost];
}

@end
