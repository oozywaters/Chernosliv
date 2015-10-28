//
//  MKCCommentsModuleInterface.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@protocol MKCCommentsModuleInterface <NSObject>

- (void)loadCommentsWithPostId:(NSString *)postId;

- (void)scrollBottomReached;

@end
