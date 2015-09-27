//
//  MKCCommentsPostDetails.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 22/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class MKCVKPost, MKCVKProfile;

@interface MKCCommentsPostDetails : NSObject

- (instancetype)initWithVKPost:(MKCVKPost *)vkPost;

@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSURL *postHeaderImageURL;
@property (nonatomic, strong) NSURL *postAuthorImageURL;
@property (nonatomic, strong) NSDate *postDate;
@property (nonatomic, strong) NSString *postContent;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic) BOOL hasAttachments;

@end
