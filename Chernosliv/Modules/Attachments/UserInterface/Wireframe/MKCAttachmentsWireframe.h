//
//  MKCAttachmentsWireframe.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class MKCVKPost;

@interface MKCAttachmentsWireframe : NSObject

- (instancetype)initWithPost:(MKCVKPost*)post;
- (void)presentAttachmentsInterfaceFromNavigationController:(UINavigationController *)navigationController;

@end
