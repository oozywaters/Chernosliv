//
//  MKCCommentsPresenter.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsPresenter.h"
#import "MKCCommentsDataSource.h"
#import "MKCCommentsPostDetails.h"

@interface MKCCommentsPresenter ()

@property (nonatomic, weak) UIViewController<MKCCommentsViewInterface> *commentsInterface;
@property (nonatomic, strong) MKCCommentsDataSource *dataSource;

@end

@implementation MKCCommentsPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataSource = [MKCCommentsDataSource new];
    }
    return self;
}

- (void)configurePresenterWithUserInterface:(UIViewController<MKCCommentsViewInterface> *)userInterface {
    self.commentsInterface = userInterface;
    [self.commentsInterface updateDataSource:self.dataSource];
    [self loadPostContent];

//    [self loadComments];
//    [self.userInterface updatePostData:self.post];
//    [self loadCommentsWithPostId:self.post.postId];
}

- (void)loadPostContent {
    MKCCommentsPostDetails *postDetails = [self.interactor currentPost];
    [self.dataSource setupStorageWithPostDetails:postDetails eventHandler:self];
    if (postDetails.hasAttachments) {
        [self.commentsInterface setHeaderViewWithImageURL:postDetails.postHeaderImageURL];
    }
    [self loadComments];
}

- (void)loadComments {
    [self.interactor loadCommentsWithCompletionHandler:^(NSArray *comments) {
        if ([comments count] == 0) {
            [self.commentsInterface nothingToLoad];
            return;
        }
        [self.dataSource setupStorageWithItems:comments eventHandler:self];
        [self.commentsInterface commentsLoaded];
    }];
}

- (void)scrollBottomReached {
    [self loadComments];
}

#pragma mark - MKCCommentsModuleInterface

- (void)likePost {
    [self.interactor likePost];
}

- (void)copyPost {
    [self.interactor copyPost];
}

@end
