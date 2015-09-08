//
//  MKCWallDataSource.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 06/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//
#import "ObservableMutableArray.h"

@class PostViewModel;

@interface MKCWallDataSource : NSObject

@property (nonatomic, strong, readonly) ObservableMutableArray *posts;

- (void)addPosts:(NSArray *)posts;

- (PostViewModel *)objectAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfPosts;

@end
