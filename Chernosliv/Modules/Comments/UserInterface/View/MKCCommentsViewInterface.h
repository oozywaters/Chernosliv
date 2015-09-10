//
//  MKCCommentsViewInterface.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class MKCCommentsPost;

@protocol MKCCommentsViewInterface <NSObject>

- (void)updatePostData:(MKCCommentsPost *)post;
- (void)updateCommentsData:(MKCCommentsPost *)post;

@end
