//
//  MKCCommentsModuleInterface.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//


@class MKCVKPost;

@protocol MKCCommentsModuleInterface <NSObject>

- (void)loadCommentsWithPostId:(NSString *)postId;

- (void)scrollBottomReached;

- (void)likePost;
- (void)copyPost;

@end
