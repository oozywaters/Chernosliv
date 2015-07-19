//
//  WallViewModel.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "ObservableMutableArray.h"

@class VKPost;

@interface WallViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong, readonly) ObservableMutableArray *posts;

- (RACCommand *)loadNextPage;

//- (NSUInteger)numberOfPosts;
//- (RACSignal *)requestRecentPosts:(NSString *)count;

//- (VKPost *)postAtIndex:(NSUInteger)index;

@end
