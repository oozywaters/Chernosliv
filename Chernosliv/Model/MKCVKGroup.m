//
//  MKCVKGroup.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 27/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVKGroup.h"

@interface MKCVKGroup ()

@property (nonatomic, strong) NSString *ownerId;

@end

@implementation MKCVKGroup

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"ownerId": @"id",
             @"name": @"name",
             @"avatar": @"photo_100"};
}

@end
