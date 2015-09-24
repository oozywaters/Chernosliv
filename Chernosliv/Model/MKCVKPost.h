//
//  MKCVKPost.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 06/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "MKCVKProfile.h"

@interface MKCVKPost : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) MKCVKProfile *authorProfile;
@property (nonatomic, strong) NSString *postId;
@property (nonatomic, strong) NSString *authorId;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray *attachments;
@property (nonatomic) NSUInteger likesCount;
@property (nonatomic) NSUInteger commentsCount;
@property (nonatomic) NSUInteger repostsCount;

@end
