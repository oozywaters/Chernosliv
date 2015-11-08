//
//  MKCWallInteractor.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 20/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallInteractor.h"
#import "MKCWallDataManager.h"
#import "VKService.h"

@interface MKCWallInteractor ()

@property (nonatomic, strong) MKCWallDataManager *dataManager;

@end

@implementation MKCWallInteractor

- (instancetype)initWithDataManager:(MKCWallDataManager *)dataManager {
    self = [super init];
    if (self) {
        _dataManager = dataManager;
    }
    return self;
}

- (void)addLikeToPost:(MKCVKPost *)post {
    [self.dataManager addLikeToPost:post];
}

- (void)loadPostsWithCompletionHandler:(void (^)(NSArray *))completionHandler {
    [self.dataManager loadPostsWithCompletion:completionHandler error:^(NSError *error) {
        NSLog(@"Error while loading posts: %@", error);
    }];
}
//- (void)loadPosts {
//    [[VKService sharedService] getPostsWithOffset:self.posts.count count:pageSize onSuccess:^(NSArray *posts) {
//        NSArray *newPosts = [posts linq_select:^id(VKPost *post) {
//            PostViewModel *pvm = [[PostViewModel alloc] initWithPost:post];
//            pvm.delegate = self;
//            return pvm;
//        }];
//        [self.posts addObjectsFromArray:newPosts];
//    } onError:^(NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//}

@end
