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
#import "MKCCommentsPostDetails.h"

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

- (void)loadCommentsWithCompletionHandler:(void (^)(NSArray *))completionHandler {
    [self.dataManager getCommentsWithSuccess:^(NSArray *comments) {
        completionHandler(comments);
    } error:^(NSError *error) {
        NSLog(@"Error while loading comments: %@", error);
    }];
}

//- (MKCCommentsPostDetails *)currentPostDetails {
//    MKCVKPost *post = self.dataManager.post;
//    MKCVKProfile *profile = [self.dataManager profileWithId:post.authorId];
//    MKCCommentsPostDetails *commentsPost = [[MKCCommentsPostDetails alloc] initWithVKPost:post authorProfile:profile];
//    return commentsPost;
//}

- (MKCCommentsPostDetails *)currentPost {
    MKCVKPost *post = self.dataManager.post;
    MKCCommentsPostDetails *commentsPost = [[MKCCommentsPostDetails alloc] initWithVKPost:post];
    return commentsPost;
}
@end
