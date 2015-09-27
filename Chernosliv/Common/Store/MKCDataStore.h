//
//  MKCDataStore.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 05/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVKOwner.h"

@class MKCVKPost, MKCVKProfile;

@interface MKCDataStore : NSObject

+ (MKCDataStore *)sharedStore;

- (void)storePosts:(NSArray *)posts;
- (void)storePostOwners:(NSDictionary *)owners;
- (void)storeProfiles:(NSDictionary *)profiles;

- (MKCVKPost *)postWithId:(NSString *)postId;
- (MKCVKProfile *)profileWithId:(NSString *)profileId;
- (MKCVKOwner *)ownerWithId:(NSString *)ownerId;

- (NSUInteger)postsCount;

@end
