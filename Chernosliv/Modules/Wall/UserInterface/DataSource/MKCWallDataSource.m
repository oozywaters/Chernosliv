//
//  MKCWallDataSource.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 06/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallDataSource.h"
#import "PostViewModel.h"

#import <ANStorage/ANMemoryStorage.h>

@interface MKCWallDataSource ()

@end

@implementation MKCWallDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        self.storage = [ANMemoryStorage storage];
//        _posts = [ObservableMutableArray new];
    }
    return self;
}

- (void)addPosts:(NSArray *)posts {
//    posts = [[posts.rac_sequence map:^id(MKCVKPost *postModel) {
//        return [[PostViewModel alloc] initWithPost:postModel];
//    }] array];
    
    [self.posts addObjectsFromArray:posts];
}

- (PostViewModel *)objectAtIndex:(NSUInteger)index {
    if (index <= self.posts.count) {
        return [self.posts objectAtIndex:index];
    }
    return nil;
}

- (NSUInteger)numberOfPosts {
    return self.posts.count;
}

- (void)setupStorageWithItems:(NSArray *)items eventHandler:(id<MKCWallModuleInterface>)eventHandler {
    if (!ANIsEmpty(items)) {
        items = [[items.rac_sequence map:^id(MKCVKPost *post) {
            PostViewModel *viewModel = [[PostViewModel alloc] initWithPost:post];
            viewModel.eventHandelr = eventHandler;
            return viewModel;
        }] array];
//        [self.storage removeAllItems];
        [self.storage addItems:items];
    }
}

@end
