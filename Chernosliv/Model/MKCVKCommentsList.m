//
//  MKCVKCommentsList.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 04/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVKCommentsList.h"
#import "MKCVKComment.h"
#import "MKCVKProfile.h"

@implementation MKCVKCommentsList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"profiles": @"profiles",
             @"comments": @"items"};
}

+ (NSValueTransformer *)commentsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MKCVKComment class]];
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


//- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
//    self = [super initWithDictionary:dictionaryValue error:error];
//    if (self) {
//        for (MKCVKComment *comment in self.comments) {
//            comment.author = [self.profiles objectForKey:comment.authorId];
//        }
//    }
//    return self;
//}

@end
