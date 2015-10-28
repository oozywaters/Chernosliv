//
//  MKCCommentsInteractorIO.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//
@class MKCCommentsPostDetails;

@protocol MKCCommentsInteractorInput <NSObject>

- (void)loadCommentsWithCompletionHandler:(void(^)(NSArray *comments))completionHandler;

- (MKCCommentsPostDetails *)currentPost;

@end

@protocol MKCCommentsInteractorOutput <NSObject>

@end