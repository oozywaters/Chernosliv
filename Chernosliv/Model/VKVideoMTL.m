//
//  VKVideoMTL.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 01.08.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "VKVideoMTL.h"

@implementation VKVideoMTL

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"type": @"type",
             @"identifier": @"video.id",
             @"thumbnail": @"video"};
}

+ (NSValueTransformer *)thumbnailJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *dict, BOOL *success, NSError *__autoreleasing *error) {
        NSString *urlString;
        if (dict[@"photo_800"] != nil) {
            urlString = dict[@"photo_800"];
        } else if (dict[@"photo_640"] != nil) {
            urlString = dict[@"photo_640"];
        } else if (dict[@"photo_320"] != nil) {
            urlString = dict[@"photo_320"];
        } else if (dict[@"photo_130"] != nil) {
            urlString = dict[@"photo_130"];
        }
        return [NSURL URLWithString:urlString];
    }];
}

@end
