//
//  MKCCommentsPresenter.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsPresenter.h"
#import "MKCCommentsPost.h"

@interface MKCCommentsPresenter ()

@property (nonatomic, strong) MKCCommentsPost *post;

@end

@implementation MKCCommentsPresenter

- (void)configurePresenterWithUserInterface:(UIViewController<MKCCommentsViewInterface> *)userInterface {
    _userInterface = userInterface;
    _post = [self.interactor currentPost];
    NSLog(@"Current post: %@", _post.postHeaderImageURL);
    [self loadComments];
    [self.userInterface updatePostData:self.post];
//    [self loadCommentsWithPostId:self.post.postId];
}

- (void)loadComments {
    [self.interactor loadComments];
}

- (void)commentsLoaded:(NSArray *)comments {
    NSLog(@"aklsdjflkdj");
    NSLog(@"Interactor received comments: %@", comments);
}

@end
