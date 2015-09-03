//
//  MKCCommentsDataManager.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsDataManager.h"
#import "VKService.h"

@interface MKCCommentsDataManager ()

@property (nonatomic, strong) NSArray *comments;

@end

@implementation MKCCommentsDataManager

- (void)getCommentsWithPostId:(NSString *)postId
                       success:(void (^)(NSArray *))successBlock
                         error:(void (^)(NSError *))errorBlock {
    [[VKService sharedService] getCommentsWithPostId:postId success:^(NSArray *comments) {
        NSLog(@"Comments success");
        successBlock(comments);
    } error:^(NSError *error) {
        NSLog(@"Comments error");
        errorBlock(error);
    }];
}

@end
