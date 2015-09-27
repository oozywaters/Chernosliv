//
//  MKCWallGetResponse.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 06/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallGetResponse.h"
#import "MKCVKPost.h"
#import "MKCVKProfile.h"
#import "MKCVKGroup.h"

@implementation MKCWallGetResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"totalPostsCount": @"count",
             @"posts": @"items",
             @"profiles": @"profiles",
             @"groups": @"groups"};
}

+ (NSValueTransformer *)postsJSONTransformer {
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[MKCVKPost class]];
//    return [MTLJSONAdapter arrayTransformerWithModelClass:[MKCVKPost class]];
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *posts, BOOL *success, NSError *__autoreleasing *error) {
        NSError *internalError;
        NSMutableArray *results = [NSMutableArray array];
        for (NSDictionary *JSONDictionary in posts) {
            MKCVKPost *vkPost = [adapter modelFromJSONDictionary:JSONDictionary error:&internalError];
            if (vkPost.copiedPosts) {
                MKCVKPost *copiedPost = vkPost.copiedPosts.lastObject;
                copiedPost.postId = vkPost.postId;
                copiedPost.likesCount = vkPost.likesCount;
                copiedPost.repostsCount = vkPost.repostsCount;
                copiedPost.commentsCount = vkPost.commentsCount;
                [results addObject:copiedPost];
                continue;
            }
            [results addObject:vkPost];
//            if (!vkPost.attachments && [vkPost.text isEqualToString:@""]) {
////                *error = internalError;
////                *success = NO;
//                continue;
//            } else {
//                if (vkPost.copiedPosts) {
//                    [results addObject:vkPost.copiedPosts.lastObject];
//                    continue;
//                }
//                [results addObject:vkPost];
//            }
        }
        if (results.count == 0) {
            return nil;
        }
        return results;
    }];
}

+ (NSValueTransformer *)profilesJSONTransformer {
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[MKCVKProfile class]];
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *profiles, BOOL *success, NSError *__autoreleasing *error) {
        NSError *internalError;
        NSMutableArray *keys = [NSMutableArray array];
        NSMutableArray *objects = [NSMutableArray array];
        for (NSDictionary *JSONDictionary in profiles) {
            [keys addObject:JSONDictionary[@"id"]];
            MKCVKProfile *profile = [adapter modelFromJSONDictionary:JSONDictionary error:&internalError];
            [objects addObject:profile];
        }
        NSDictionary *results = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        return results;
    }];
}

+ (NSValueTransformer *)groupsJSONTransformer {
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[MKCVKGroup class]];
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *groups, BOOL *success, NSError *__autoreleasing *error) {
        NSError *internalError;
        NSMutableArray *keys = [NSMutableArray array];
        NSMutableArray *objects = [NSMutableArray array];
        for (NSDictionary *JSONDictionary in groups) {
            NSInteger groupId = [(NSNumber *)JSONDictionary[@"id"] integerValue] * -1;
            [keys addObject:[NSNumber numberWithInteger:groupId]];
            MKCVKGroup *group = [adapter modelFromJSONDictionary:JSONDictionary error:&internalError];
            [objects addObject:group];
        }
        NSDictionary *results = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        return results;
    }];
}

@end
