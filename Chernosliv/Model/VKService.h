//
//  VKService.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 12.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VKWall;

@interface VKService : NSObject

+ (VKService *)sharedService;
- (RACSignal *)posts;

@property (nonatomic, strong) VKWall *wall;

- (void)getPostsWithOffset:(NSUInteger)offset
                         count:(NSUInteger)count
                     onSuccess:(void (^)(NSArray *posts))successBlock
                       onError:(void (^)(NSError *error))errorBlock;

@end
