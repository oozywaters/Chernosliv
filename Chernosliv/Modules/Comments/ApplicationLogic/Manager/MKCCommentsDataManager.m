//
//  MKCCommentsDataManager.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsDataManager.h"
#import "MKCDataStore.h"
#import "VKService.h"
#import "MKCVKPost.h"
#import "MKCVKProfile.h"
#import "MKCVKComment.h"

@interface MKCCommentsDataManager ()

@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableDictionary *profiles;
@property (nonatomic, strong) MKCVKCommentsList *commentsList;

@end

@implementation MKCCommentsDataManager

- (instancetype)initWithPost:(MKCVKPost *)post {
    if (self) {
        _post = post;
        _comments = [NSMutableArray array];
        _profiles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)getCommentsWithSuccess:(void (^)(NSArray *))successBlock
                         error:(void (^)(NSError *))errorBlock {
    [[VKService sharedService] getCommentsWithPostId:self.post.postId success:^(MKCVKCommentsList *commentsList) {
//        MKCVKComment *comment = commentsList.comments[0];
//        comment.author = [commentsList.profiles objectForKey:comment.authorId];
//        NSLog(@"Comment: %@", comment);

        commentsList.comments = [[commentsList.comments.rac_sequence map:^id(MKCVKComment *comment) {
            comment.author = [commentsList.profiles objectForKey:comment.authorId];
            return comment;
        }] array];
//
        
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

- (MKCVKProfile *)profileWithId:(NSString *)identifier {
    MKCVKProfile *profile = [[MKCDataStore sharedStore] profileWithId:identifier];
    return profile;
}

@end
