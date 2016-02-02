//
//  MKCCommentsPostDetailsViewModel.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 22/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsModuleInterface.h"

@class MKCCommentsPostDetails;

@interface MKCCommentsPostDetailsViewModel : NSObject

@property (nonatomic, strong, readonly) NSString *authorName;
@property (nonatomic, strong, readonly) NSURL *authorImageURL;
@property (nonatomic, strong, readonly) NSString *postContent;
@property (nonatomic, strong, readonly) NSDate *postDate;
@property (nonatomic, strong, readonly) NSURL *headerImage;
@property (nonatomic, strong) NSString *likesCount;
@property (nonatomic, strong) NSString *repostsCount;
@property (nonatomic) BOOL isUserLikes;
@property (nonatomic) BOOL isUserReposted;

@property (nonatomic, weak) id<MKCCommentsModuleInterface> eventHandler;

+ (instancetype)viewModelWithPostDetails:(MKCCommentsPostDetails *)postDetails;
- (instancetype)initWithModel:(MKCCommentsPostDetails *)postDetails;

- (void)copyPost;
- (void)likePost;


@end
