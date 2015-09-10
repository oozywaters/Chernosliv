//
//  MKCCommentsPost.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 10/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//
@class MKCVKPost, MKCVKProfile;

@interface MKCCommentsPost : NSObject

- (instancetype)initWithVKPost:(MKCVKPost *)vkPost authorProfile:(MKCVKProfile *)authorProfile;

@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSURL *postHeaderImageURL;
@property (nonatomic, strong) NSURL *postAuthorImageURL;
@property (nonatomic, strong) NSDate *postDate;
@property (nonatomic, strong) NSString *postContent;
@property (nonatomic, strong) NSArray *comments;

@end
