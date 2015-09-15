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

@implementation MKCWallGetResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"totalPostsCount": @"count",
             @"posts": @"items",
             @"profiles": @"profiles"};
}

+ (NSValueTransformer *)postsJSONTransformer {
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[MKCVKPost class]];
//    return [MTLJSONAdapter arrayTransformerWithModelClass:[MKCVKPost class]];
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *posts, BOOL *success, NSError *__autoreleasing *error) {
        NSError *internalError;
        NSMutableArray *results = [NSMutableArray array];
        for (NSDictionary *JSONDictionary in posts) {
            MKCVKPost *vkPost = [adapter modelFromJSONDictionary:JSONDictionary error:&internalError];
            if (!vkPost.attachments && [vkPost.text isEqualToString:@""]) {
//                *error = internalError;
//                *success = NO;
                continue;
            } else {
                [results addObject:vkPost];
            }
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

@end
