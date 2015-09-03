//
//  VKPost.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "VKPost.h"
#import "VKAttachment.h"

@implementation VKPost

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"postId": @"id",
             @"text": @"text",
             @"date": @"date",
             @"attachments": @"attachments"};
}

//+ (NSValueTransformer *)attachmentsJSONTransformer {
//    return [MTLJSONAdapter arrayTransformerWithModelClass:[VKAttachment class]];
//}

+ (NSValueTransformer *)attachmentsJSONTransformer {
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[VKAttachment class]];
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *attachments, BOOL *success, NSError *__autoreleasing *error) {
        NSError *internalError;
        NSMutableArray *results = [NSMutableArray arrayWithCapacity:attachments.count];
        for (NSDictionary *JSONDictionary in attachments) {
            VKAttachment *vkAttachment = [adapter modelFromJSONDictionary:JSONDictionary error:&internalError];
            if (vkAttachment == nil && internalError.code != MTLJSONAdapterErrorNoClassFound) {
                *error = internalError;
                *success = NO;
                return nil;
            } else if (vkAttachment != nil) {
                [results addObject:vkAttachment];
            }
        }
//        NSLog(@"%@", results);
        return results;
    }];
}

@end
