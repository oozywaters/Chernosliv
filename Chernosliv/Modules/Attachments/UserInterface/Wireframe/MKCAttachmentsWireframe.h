//
//  MKCAttachmentsWireframe.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class VKPost;

@interface MKCAttachmentsWireframe : NSObject

- (instancetype)initWithPost:(VKPost *)post;
- (void)presentAttachmentsInterfaceFromNavigationController:(UINavigationController *)navigationController;

@end
