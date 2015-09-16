//
//  MKCWallDataSource.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 06/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//
#import "ObservableMutableArray.h"

#import "MKCWallModuleInterface.h"

@class PostViewModel;
@class ANMemoryStorage;

@interface MKCWallDataSource : NSObject

@property (nonatomic, strong) ANMemoryStorage *storage;

@property (nonatomic, strong, readonly) ObservableMutableArray *posts;

- (void)addPosts:(NSArray *)posts;

- (PostViewModel *)objectAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfPosts;

- (void)setupStorageWithItems:(NSArray*)items eventHandler:(id<MKCWallModuleInterface>)eventHandler;

@end
