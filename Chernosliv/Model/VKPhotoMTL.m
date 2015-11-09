//
//  VKPhotoMTL.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 19.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "VKPhotoMTL.h"

@implementation VKPhotoMTL

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"type": @"type",
             @"identifier": @"photo.id",
             @"size": @"photo",
             @"url": @"photo",
             @"thumbnail": @"photo.photo_75"};
}

+ (NSValueTransformer *)sizeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *dict, BOOL *success, NSError *__autoreleasing *error) {
        CGFloat width = [dict[@"width"] doubleValue];
        CGFloat height = [dict[@"height"] doubleValue];
        if (width == 0 && height == 0) {
            NSString *urlString;
            if (dict[@"photo_2560"] != nil) {
                urlString = dict[@"photo_2560"];
            } else if (dict[@"photo_1280"] != nil) {
                urlString = dict[@"photo_1280"];
            } else if (dict[@"photo_807"] != nil) {
                urlString = dict[@"photo_807"];
            } else if (dict[@"photo_604"] != nil) {
                urlString = dict[@"photo_604"];
            } else if (dict[@"photo_130"] != nil) {
                urlString = dict[@"photo_130"];
            } else if (dict[@"photo_75"] != nil) {
                urlString = dict[@"photo_75"];
            }
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:imageData];
            width = image.size.width;
            height = image.size.height;
        }
        return [NSValue valueWithCGSize:CGSizeMake(width, height)];
    }];
}

+ (NSValueTransformer *)urlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *dict, BOOL *success, NSError *__autoreleasing *error) {
        NSString *urlString;
        if (dict[@"photo_2560"] != nil) {
            urlString = dict[@"photo_2560"];
        } else if (dict[@"photo_1280"] != nil) {
            urlString = dict[@"photo_1280"];
        } else if (dict[@"photo_807"] != nil) {
            urlString = dict[@"photo_807"];
        } else if (dict[@"photo_604"] != nil) {
            urlString = dict[@"photo_604"];
        } else if (dict[@"photo_130"] != nil) {
            urlString = dict[@"photo_130"];
        } else if (dict[@"photo_75"] != nil) {
            urlString = dict[@"photo_75"];
        }
        return [NSURL URLWithString:urlString];
    }];
}

@end
