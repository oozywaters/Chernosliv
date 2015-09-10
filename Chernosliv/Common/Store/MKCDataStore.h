//
//  MKCDataStore.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 05/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class MKCVKPost, MKCVKProfile;

@interface MKCDataStore : NSObject

+ (MKCDataStore *)sharedStore;

- (void)storePosts:(NSArray *)posts;
- (void)storeProfiles:(NSDictionary *)profiles;

- (MKCVKPost *)postWithId:(NSString *)postId;
- (MKCVKProfile *)profileWithId:(NSString *)profileId;

- (NSUInteger)postsCount;

@end
