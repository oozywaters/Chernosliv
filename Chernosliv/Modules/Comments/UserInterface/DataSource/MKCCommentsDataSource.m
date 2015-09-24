//
//  MKCCommentsDataSource.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 15/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <ANStorage/ANMemoryStorage.h>
#import "MKCCommentsDataSource.h"
#import "MKCCommentsPostDetailsViewModel.h"
#import "MKCVKComment.h"
#import "MKCCommentViewModel.h"

@implementation MKCCommentsDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        self.storage = [ANMemoryStorage storage];
    }
    return self;
}

- (void)setupStorageWithItems:(NSArray *)items eventHandler:(id<MKCCommentsModuleInterface>)eventHandler {
    if (!ANIsEmpty(items)) {
        items = [[items.rac_sequence map:^id(MKCVKComment *comment) {
            MKCCommentViewModel *viewModel = [MKCCommentViewModel viewModelWithComment:comment];
            viewModel.eventHandler = eventHandler;
            return viewModel;
        }] array];
        //        [self.storage removeAllItems];
        [self.storage addItems:items];
    }
}

- (void)setupStorageWithPostDetails:(MKCCommentsPostDetails *)postDetails
                       eventHandler:(id<MKCCommentsModuleInterface>)eventHandler {
    if (postDetails) {
        MKCCommentsPostDetailsViewModel *postDetailsViewModel = [MKCCommentsPostDetailsViewModel viewModelWithPostDetails:postDetails];
        postDetailsViewModel.eventHandler = eventHandler;
        [self.storage addItem:postDetailsViewModel];
    }
}

@end
