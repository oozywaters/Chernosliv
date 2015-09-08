//
//  MKCCommentsDataManager.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsDataManager.h"
#import "VKService.h"
#import "MKCVKProfile.h"
#import "MKCVKComment.h"

@interface MKCCommentsDataManager ()

@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableDictionary *profiles;
@property (nonatomic, strong) MKCVKCommentsList *commentsList;

@end

@implementation MKCCommentsDataManager

- (instancetype)init {
    if (self) {
        _comments = [NSMutableArray array];
        _profiles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)getCommentsWithPostId:(NSString *)postId
                       success:(void (^)(NSArray *))successBlock
                         error:(void (^)(NSError *))errorBlock {
    [[VKService sharedService] getCommentsWithPostId:postId success:^(MKCVKCommentsList *commentsList) {
        if (!self.commentsList) {
            self.commentsList = commentsList;
        } else {
            [self.commentsList mergeValuesForKeysFromModel:commentsList];
        }
        successBlock(self.commentsList.comments);
    } error:^(NSError *error) {
        NSLog(@"Comments error");
        errorBlock(error);
    }];
}

@end