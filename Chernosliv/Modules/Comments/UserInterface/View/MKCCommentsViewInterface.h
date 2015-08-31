//
//  MKCCommentsViewInterface.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class VKPost;

@protocol MKCCommentsViewInterface <NSObject>

- (void)updateCommentsData:(VKPost *)post;

@end
