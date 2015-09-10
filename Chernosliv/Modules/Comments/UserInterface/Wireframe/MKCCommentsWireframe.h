//
//  MKCCommentsWireframe.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class MKCVKPost;

@interface MKCCommentsWireframe : NSObject

- (instancetype)initWithPost:(MKCVKPost *)post;
- (void)presentCommentsInterfaceFromNavigationController:(UINavigationController *)navigationController;

@end
