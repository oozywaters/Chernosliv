//
//  MKCVKPost.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 06/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVKPost.h"
#import "VKAttachment.h"
#import "MKCDataStore.h"

@implementation MKCVKPost

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"postId": @"id",
             @"authorId": @"from_id",
             @"text": @"text",
             @"date": @"date",
             @"attachments": @"attachments",
             @"copiedPosts": @"copy_history",
             @"likesCount": @"likes.count",
             @"commentsCount": @"comments.count",
             @"repostsCount": @"reposts.count",
             @"isUserLikes": @"likes.user_likes",
             @"isUserReposted": @"reposts.user_reposted"
             };
}

+ (NSValueTransformer *)dateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *time, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    }];
}

+ (NSValueTransformer *)attachmentsJSONTransformer {
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[VKAttachment class]];
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *attachments, BOOL *success, NSError *__autoreleasing *error) {
        NSError *internalError;
        NSMutableArray *results = [NSMutableArray array];
        for (NSDictionary *JSONDictionary in attachments) {
            VKAttachment *vkAttachment = [adapter modelFromJSONDictionary:JSONDictionary error:&internalError];
            if (vkAttachment == nil && internalError.code != MTLJSONAdapterErrorNoClassFound) {
                *error = internalError;
                *success = NO;
                return nil;
//                continue;
            } else if (vkAttachment != nil) {
                [results addObject:vkAttachment];
            }
        }
        if (results.count == 0) {
            return nil;
        }
        return results;
    }];
}

+ (NSValueTransformer *)copiedPostsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MKCVKPost class]];
}


- (MKCVKOwner *)postOwner {
    if (!_postOwner) {
        _postOwner = [[MKCDataStore sharedStore] ownerWithId:self.authorId];
    }
    return _postOwner;
}

@end
