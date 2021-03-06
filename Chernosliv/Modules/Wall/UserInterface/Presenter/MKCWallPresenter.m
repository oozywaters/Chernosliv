//
//  MKCWallPresenter.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallPresenter.h"
#import "MKCWallViewInterface.h"
#import "MKCWallDataSource.h"

#import "PostViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MKCWallPresenter ()

@property (nonatomic, strong) MKCWallDataSource *dataSource;

//@property (nonatomic, strong, readonly) ObservableMutableArray *posts;

@property (nonatomic, strong) MKCVKPost *currentPost;
@property (nonatomic) BOOL endOfWallReached;

@property (nonatomic, weak) UIViewController<MKCWallViewInterface> *wallInterface;

@end

@implementation MKCWallPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _dataSource = [MKCWallDataSource new];
    _endOfWallReached = NO;
    //    [[self loadNextPage]execute:nil];
}

- (void)configurePresenterWithUserInterface:(UIViewController<MKCWallViewInterface> *)userInterface {
    self.wallInterface = userInterface;
    [self.wallInterface updateDataSource:self.dataSource];
    [self loadNextPage];
}

- (void)loadNextPage {
    [self.interactor loadPostsWithCompletionHandler:^(NSArray *posts) {
        if (!posts) {
            // End of wall reached
            [self.wallInterface nothingToLoad];
            return;
        }
        [self.dataSource setupStorageWithItems:posts eventHandler:self];
        [self.wallInterface pageLoaded];
    }];
}

#pragma mark - MKCWallModuleInterface

- (void)addLikeToPost:(MKCVKPost *)post withResult:(void (^)(NSNumber *))completionBlock {
    [self.interactor addLikeToPost:post withCompletionHandler:completionBlock];
}

- (void)copyWithPost:(MKCVKPost *)post {
    [self.interactor copyWithPost:post];
}

- (void)viewCommentsWithModel:(PostViewModel *)viewModel {
    [self.wireframe presentCommentsControllerWithPost:viewModel.post];
}

- (void)viewAttachmentsWithModel:(PostViewModel *)viewModel {
    [self.wallInterface attachmentsTappedWithView:viewModel.tappedImage];
    [self.wireframe presentAttachmentsControllerWithPost:viewModel.post];
}


@end
