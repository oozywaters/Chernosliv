//
//  VKService.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 12.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MKCVKCommentsList.h"

@class VKWall;
@class MKCWallGetResponse;

@interface VKService : NSObject

+ (VKService *)sharedService;

- (void)wallGetWithOffset:(NSUInteger)offset
                    count:(NSUInteger)count
                  success:(void(^)(MKCWallGetResponse *response))successBlock
                    error:(void(^)(NSError *error))errorBlock;

- (void)getCommentsWithPostId:(NSNumber *)postId
                       offset:(NSUInteger)offset
                        count:(NSUInteger)count
                      success:(void (^)(MKCVKCommentsList *commentsList))successBlock
                        error:(void(^)(NSError *error))errorBlock;

@end
