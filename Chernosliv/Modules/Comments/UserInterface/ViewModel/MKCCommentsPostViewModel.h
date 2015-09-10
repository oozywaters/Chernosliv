//
//  MKCCommentsPostViewModel.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 10/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class MKCCommentsPost;

@interface MKCCommentsPostViewModel : NSObject

- (instancetype)initWithModel:(MKCCommentsPost *)post;

@property (nonatomic, strong, readonly) NSString *authorName;
@property (nonatomic, strong, readonly) NSURL *authorImageURL;
@property (nonatomic, strong, readonly) NSString *postContent;
@property (nonatomic, strong, readonly) NSDate *postDate;

@end
