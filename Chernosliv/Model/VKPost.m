//
//  VKPost.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "VKPost.h"

@implementation VKPost

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"text": @"text",
             @"date": @"date"};
}

@end