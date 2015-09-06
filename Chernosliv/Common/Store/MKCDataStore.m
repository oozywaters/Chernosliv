//
//  MKCDataStore.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 05/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCDataStore.h"
#import "MKCWallGetResponse.h"

@interface MKCDataStore ()

@property (nonatomic, strong) NSMutableArray *posts;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableDictionary *profiles;

@end

@implementation MKCDataStore

+ (MKCDataStore *)sharedStore {
    static MKCDataStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[MKCDataStore alloc] init];
    });
    return store;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _posts = [NSMutableArray array];
        _comments = [NSMutableArray array];
        _profiles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)storePosts:(NSArray *)posts {
    [self.posts addObjectsFromArray:posts];
}

- (void)storeProfiles:(NSDictionary *)profiles {
    [self.profiles addEntriesFromDictionary:profiles];
}

- (NSUInteger)postsCount {
    return self.posts.count;
}

@end
