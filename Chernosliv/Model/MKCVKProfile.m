//
//  MKCVKProfile.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 04/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVKProfile.h"

@implementation MKCVKProfile

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"userId": @"id",
             @"firstName": @"first_name",
             @"lastName": @"last_name"};
}

@end
