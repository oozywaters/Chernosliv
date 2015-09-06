//
//  MKCDataStore.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 05/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@interface MKCDataStore : NSObject

+ (MKCDataStore *)sharedStore;

- (void)storePosts:(NSArray *)posts;
- (void)storeProfiles:(NSDictionary *)profiles;

- (NSUInteger)postsCount;

@end
