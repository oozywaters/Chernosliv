//
//  MKCCommentsPresenter.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsPresenter.h"
#import "MKCVKPost.h"

@interface MKCCommentsPresenter ()

@property (nonatomic, strong) MKCVKPost *post;

@end

@implementation MKCCommentsPresenter

- (instancetype)initWithPost:(MKCVKPost *)post {
    self = [super init];
    if (self) {
        _post = post;
    }
    return self;
}

- (void)configurePresenterWithUserInterface:(UIViewController<MKCCommentsViewInterface> *)userInterface {
    _userInterface = userInterface;
    [self.userInterface updateCommentsData:self.post];
    [self loadCommentsWithPostId:self.post.postId];
}

- (void)loadCommentsWithPostId:(NSString *)postId {
    [self.interactor loadCommentsWithPostId:postId];
}

- (void)commentsLoaded:(NSArray *)comments {
    NSLog(@"aklsdjflkdj");
    NSLog(@"Interactor received comments: %@", comments);
}

@end
