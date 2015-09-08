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
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>

@interface MKCWallPresenter () <PostViewModelDelegate>

@property (nonatomic, strong) MKCWallDataSource *dataSource;

//@property (nonatomic, strong, readonly) ObservableMutableArray *posts;

@property (nonatomic, strong) MKCVKPost *currentPost;
@property (nonatomic) BOOL endOfWallReached;

@property (nonatomic, strong) RACSignal *canLoadNextPage;

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
//    _posts = [[ObservableMutableArray alloc] init];
    _endOfWallReached = NO;
    //    [[self loadNextPage]execute:nil];
}

- (void)configurePresenterWithUserInterface:(UIViewController<MKCWallViewInterface> *)userInterface {
    self.wallInterface = userInterface;
    [self.wallInterface updateDataSource:self.dataSource];
    [self loadNextPage];
//    [self.interactor loadPosts];
}

- (void)loadNextPage {
    [self.interactor loadPosts];
}

# pragma mark - PostViewModelDelegate

- (void)attachmentsTappedWithModel:(MKCVKPost *)post {
    self.currentPost = post;
    [self.wireframe presentAttachmentsControllerWithPost:post];
}

- (void)commentsTappedWithModel:(VKPost *)post {
    [self.wireframe presentCommentsControllerWithPost:post];
//    self.currentPost = post;
}

# pragma mark - MKCWallInteractorOutput

- (void)pageLoadedWithPosts:(NSArray *)posts {
    [self.dataSource addPosts:posts];
    [self.wallInterface pageLoaded];
//    NSArray *newPosts = [posts linq_select:^id(VKPost *post) {
//        PostViewModel *pvm = [[PostViewModel alloc] initWithPost:post];
//        pvm.delegate = self;
//        return pvm;
//    }];
//    [self.posts addObjectsFromArray:newPosts];
//    [self.wallInterface pageLoaded];
}

# pragma mark - API

- (RACCommand *)viewComments {
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //        NSLog(@"%@", input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"View Comments");
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}

@end
