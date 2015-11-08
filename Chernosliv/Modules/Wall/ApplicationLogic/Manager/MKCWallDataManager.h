//
//  MKCWallDataManager.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 23/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class MKCDataStore, MKCVKPost;

@interface MKCWallDataManager : NSObject

- (void)addLikeToPost:(MKCVKPost *)post;
- (void)loadPostsWithCompletion:(void (^)(NSArray *posts))completionBlock
                          error:(void (^)(NSError *error))errorBlock;

@end
