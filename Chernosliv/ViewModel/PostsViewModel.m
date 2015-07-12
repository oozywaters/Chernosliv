//
//  PostsViewModel.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 11.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "PostsViewModel.h"
#import "PostsItemViewModel.h"

@implementation PostsViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.title = @"Recent Posts";
    _posts = [[NSMutableArray alloc] init];
    for (int i = 1; i < 5; i++) {
        NSString *postName = [NSString stringWithFormat:@"Post %d", i];
        PostsItemViewModel *post = [[PostsItemViewModel alloc] init];
        post.text = postName;
        [_posts addObject:post];
    }
}

@end
