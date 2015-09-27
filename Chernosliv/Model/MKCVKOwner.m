//
//  MKCVKOwner.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 27/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVKOwner.h"

@implementation MKCVKOwner

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"name": @"name",
             @"ownerId": @"id",
             @"avatar": @"photo_50"};
}

@end
