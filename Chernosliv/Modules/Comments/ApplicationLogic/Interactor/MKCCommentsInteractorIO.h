//
//  MKCCommentsInteractorIO.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//
@class MKCCommentsPost;

@protocol MKCCommentsInteractorInput <NSObject>

- (MKCCommentsPost *)currentPost;
- (void)loadComments;

@end

@protocol MKCCommentsInteractorOutput <NSObject>

- (void)commentsLoaded:(NSArray *)comments;

@end