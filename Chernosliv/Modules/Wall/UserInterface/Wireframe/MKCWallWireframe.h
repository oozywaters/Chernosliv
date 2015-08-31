//
//  MKCWallWireframe.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//


@class VKPost;

@interface MKCWallWireframe : NSObject

- (void)presentWallInterfaceFromWindow:(UIWindow *)window;
- (void)presentAttachmentsControllerWithPost:(VKPost *)post;
- (void)presentCommentsControllerWithPost:(VKPost *)post;

@end
