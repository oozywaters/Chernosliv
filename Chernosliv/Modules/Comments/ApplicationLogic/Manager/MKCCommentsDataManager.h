//
//  MKCCommentsDataManager.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKCCommentsDataManager : NSObject

- (void)getCommentsWithPostId:(NSString *)postId
                       success:(void(^)(NSArray *comments))success
                         error:(void(^)(NSError *error))error;

@end
