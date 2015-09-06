//
//  MKCCommentsInteractor.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsInteractor.h"
#import "MKCCommentsDataManager.h"

@interface MKCCommentsInteractor ()

@property (nonatomic, strong) MKCCommentsDataManager *dataManager;

@end

@implementation MKCCommentsInteractor

- (instancetype)initWithDataManager:(MKCCommentsDataManager *)dataManager {
    self = [super init];
    if (self) {
        _dataManager = dataManager;
    }
    return self;
}

- (void)loadCommentsWithPostId:(NSString *)postId {
    [self.dataManager getCommentsWithPostId:postId success:^(NSArray *comments) {
        NSLog(@"Interactorrrrrrr output: %@", self.output);
        
        [self.output commentsLoaded:comments];
    } error:^(NSError *error) {
        NSLog(@"Error while loading comments: %@", error);
    }];
}

@end
