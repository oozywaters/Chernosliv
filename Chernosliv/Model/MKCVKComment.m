//
//  MKCVKComment.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVKComment.h"

@implementation MKCVKComment

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"authorId": @"from_id",
             @"text": @"text"};
}

@end