//
//  MKCWallWireframe.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//


@class MKCVKPost;

@interface MKCWallWireframe : NSObject

- (void)presentWallInterfaceFromWindow:(UIWindow *)window;
- (void)presentAttachmentsControllerWithPost:(MKCVKPost *)post;
- (void)presentCommentsControllerWithPost:(MKCVKPost *)post;

@end
