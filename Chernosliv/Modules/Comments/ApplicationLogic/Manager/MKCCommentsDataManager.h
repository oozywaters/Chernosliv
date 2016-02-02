//
//  MKCCommentsDataManager.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class MKCVKPost, MKCVKProfile;

@interface MKCCommentsDataManager : NSObject

@property (nonatomic, strong, readonly) MKCVKPost *post;

- (instancetype)initWithPost:(MKCVKPost *)post;
- (void)getCommentsWithSuccess:(void(^)(NSArray *comments))success
                         error:(void(^)(NSError *error))error;
- (MKCVKProfile *)profileWithId:(NSString *)identifier;
- (void)likePost;
- (void)copyPost;

@end
