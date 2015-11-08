//
//  MKCWallDataManager.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 23/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallDataManager.h"
#import "MKCVKPost.h"
#import "MKCDataStore.h"
#import "MKCWallGetResponse.h"
#import "VKService.h"

@interface MKCWallDataManager ()

@property (nonatomic, strong) NSMutableArray *posts;

@end

@implementation MKCWallDataManager {
    NSUInteger _pageSize;
    NSUInteger _offset;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _posts = [NSMutableArray array];
        _pageSize = 100;
        _offset = 0;
    }
    return self;
}

- (void)addLikeToPost:(MKCVKPost *)post {
    [[VKService sharedService] addLikeToPost:post];
}

- (void)loadPostsWithCompletion:(void (^)(NSArray *))completionBlock error:(void (^)(NSError *))errorBlock {
    MKCDataStore *dataStore = [MKCDataStore sharedStore];
    
    [[VKService sharedService] wallGetWithOffset:_offset count:_pageSize success:^(MKCWallGetResponse *response) {
        [dataStore storePosts:response.posts];
        [dataStore storePostOwners:response.profiles];
        [dataStore storePostOwners:response.groups];
//        [dataStore storeProfiles:response.profiles];
        completionBlock(response.posts);
        _offset += _pageSize;
    } error:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
