//
//  MKCVKPost.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 06/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVKPost.h"
#import "VKAttachment.h"

@implementation MKCVKPost

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"postId": @"id",
             @"authorId": @"from_id",
             @"text": @"text",
             @"date": @"date",
             @"attachments": @"attachments",
             @"likesCount": @"likes.count",
             @"commentsCount": @"comments.count",
             @"repostsCount": @"reposts.count"};
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
//                return nil;
                continue;
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

@end
