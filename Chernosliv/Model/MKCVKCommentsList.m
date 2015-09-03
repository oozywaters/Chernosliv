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
    return @{@"comments": @"items",
             @"profiles": @"profiles"};
}

+ (NSValueTransformer *)commentsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MKCVKComment class]];
}

+ (NSValueTransformer *)profilesJSONTransformer {
    NSLog(@"profiles transformer");
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MKCVKProfile class]];
}

@end
