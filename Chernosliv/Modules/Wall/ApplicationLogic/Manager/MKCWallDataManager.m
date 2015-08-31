//
//  MKCWallDataManager.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 23/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallDataManager.h"
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
    [[VKService sharedService] getPostsWithOffset:self.posts.count count:pageSize onSuccess:^(NSArray *posts) {
        [self.posts addObjectsFromArray:posts];
        completionBlock(posts);
    } onError:^(NSError *error) {
        errorBlock(error);
    }];
    
    [[VKService sharedService] getNewPosts];
}

@end
