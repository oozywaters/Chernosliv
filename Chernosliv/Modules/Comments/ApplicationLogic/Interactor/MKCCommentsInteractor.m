//
//  MKCCommentsInteractor.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsInteractor.h"
#import "MKCCommentsDataManager.h"
#import "MKCVKPost.h"
#import "MKCVKProfile.h"
#import "MKCCommentsPost.h"

@interface MKCCommentsInteractor ()

@property (nonatomic, strong) MKCCommentsDataManager *dataManager;

@end

@implementation MKCCommentsInteractor

- (instancetype)initWithDataManager:(MKCCommentsDataManager *)dataManager {
    self = [super init];
    if (self) {
        _dataManager = dataManager;
    }
    return self;
}

- (void)loadComments {
    [self.dataManager getCommentsWithSuccess:^(NSArray *comments) {
        NSLog(@"Interactorrrrrrr output: %@", self.output);
        
        [self.output commentsLoaded:comments];
    } error:^(NSError *error) {
        NSLog(@"Error while loading comments: %@", error);
    }];
}

- (MKCCommentsPost *)currentPost {
    MKCVKPost *post = self.dataManager.post;
    MKCVKProfile *profile = [self.dataManager profileWithId:post.authorId];
    MKCCommentsPost *commentsPost = [[MKCCommentsPost alloc] initWithVKPost:post authorProfile:profile];
    return commentsPost;
}

@end
