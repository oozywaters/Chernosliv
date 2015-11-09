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
             @"size": @"video",
             @"url": @"video"};
}

+ (NSValueTransformer *)urlJSONTransformer {
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

+ (NSValueTransformer *)sizeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *dict, BOOL *success, NSError *__autoreleasing *error) {
        CGFloat width = [dict[@"width"] doubleValue];
        CGFloat height = [dict[@"height"] doubleValue];
        if (dict[@"photo_800"] != nil) {
            width = 800;
            height = 600;
        } else if (dict[@"photo_640"] != nil) {
            width = 640;
            height = 480;
        } else if (dict[@"photo_320"] != nil) {
            width = 320;
            height = 240;
        } else if (dict[@"photo_130"] != nil) {
            width = 130;
            height = 97;
        }
        return [NSValue valueWithCGSize:CGSizeMake(width, height)];
    }];
}

@end
