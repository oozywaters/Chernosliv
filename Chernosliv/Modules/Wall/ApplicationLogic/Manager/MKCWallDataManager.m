//
//  MKCWallDataManager.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 23/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallDataManager.h"
#import "MKCDataStore.h"
#import "MKCWallGetResponse.h"
#import "VKService.h"

@interface MKCWallDataManager ()

@property (nonatomic, strong) NSMutableArray *posts;

@end

@implementation MKCWallDataManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _posts = [NSMutableArray array];
    }
    return self;
}

static NSUInteger const pageSize = 5;

- (void)loadPostsWithCompletion:(void (^)(NSArray *))completionBlock error:(void (^)(NSError *))errorBlock {
    MKCDataStore *dataStore = [MKCDataStore sharedStore];
    NSUInteger offset = [dataStore postsCount];
    
    [[VKService sharedService] wallGetWithOffset:offset count:pageSize success:^(MKCWallGetResponse *response) {
        [dataStore storePosts:response.posts];
        [dataStore storeProfiles:response.profiles];
        completionBlock(response.posts);
    } error:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
