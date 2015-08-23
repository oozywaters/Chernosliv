//
//  MKCWallDataManager.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 23/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKCWallDataManager : NSObject

- (void)loadPostsWithCompletion:(void (^)(NSArray *posts))completionBlock
                          error:(void (^)(NSError *error))errorBlock;

@end
