//
//  WallViewModel.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "WallViewModel.h"
//#import "PostsItemViewModel.h"
#import "VKService.h"
#import <VKSdk.h>
#import <Mantle.h>
#import "VKWall.h"
#import "VKPost.h"
#import "PostViewModel.h"
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>


@interface WallViewModel ()

//@property (nonatomic, strong, readonly) NSMutableArray *posts;
@property (nonatomic, strong) VKService *vkService;
@property (nonatomic) BOOL endOfWallReached;

@property (nonatomic, strong) RACSignal *canLoadNextPage;

@property (nonatomic, weak) id<ViewModelServices> services;

@end

@implementation WallViewModel

static NSUInteger const pageSize = 5;

- (instancetype)initWithServices:(id<ViewModelServices>)services {
    self = [super init];
    if (self) {
        _services = services;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.title = @"Recent Posts";
    _posts = [[ObservableMutableArray alloc] init];
    _endOfWallReached = NO;
    
    _canLoadNextPage = [RACObserve(self, endOfWallReached) not];
    
    
//    [[self loadNextPage]execute:nil];
}

- (RACSignal *)nextPage {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[VKService sharedService] getPostsWithOffset:self.posts.count count:pageSize onSuccess:^(NSArray *posts) {
            NSArray *newPosts = [posts linq_select:^id(VKPost *post) {
                return [[PostViewModel alloc] initWithPost:post services:self.services];
            }];
            [self.posts addObjectsFromArray:newPosts];
            NSLog(@"%lu", self.posts.count);
            [subscriber sendCompleted];
        } onError:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}

# pragma mark - API

- (RACCommand *)loadNextPage {
    return [[RACCommand alloc] initWithEnabled:self.canLoadNextPage signalBlock:^RACSignal *(id input) {
        return [self nextPage];
    }];
}

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
