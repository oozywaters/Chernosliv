//
//  MKCVKPost.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 06/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "MKCVKOwner.h"

@interface MKCVKPost : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) MKCVKOwner *postOwner;
@property (nonatomic, strong) NSNumber *postId;
@property (nonatomic, strong) NSNumber *authorId;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray *attachments;
@property (nonatomic, strong) NSArray *copiedPosts;
@property (nonatomic) NSUInteger likesCount;
@property (nonatomic) NSUInteger commentsCount;
@property (nonatomic) NSUInteger repostsCount;

@end
