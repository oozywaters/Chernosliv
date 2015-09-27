//
//  MKCVKProfile.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 04/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVKProfile.h"

@interface MKCVKProfile ()

@property (nonatomic, strong) NSString *ownerId;

@end

@implementation MKCVKProfile

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"ownerId": @"id",
             @"firstName": @"first_name",
             @"lastName": @"last_name",
             @"avatar": @"photo_100"};
}

- (NSString *)name {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end
