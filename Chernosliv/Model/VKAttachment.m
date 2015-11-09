//
//  VKAttachment.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 19.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "VKAttachment.h"
#import "VKPhotoMTL.h"
#import "VKVideoMTL.h"

@implementation VKAttachment

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"type": @"type"};
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
    
    if([JSONDictionary[@"type"] isEqual:@"photo"]) {
        return [VKPhotoMTL class];
    }
    
//    if([JSONDictionary[@"type"] isEqual:@"posted_photo"]) {
//        return [VKPhotoMTL class];
//    }
    
//    if([JSONDictionary[@"type"] isEqual:@"video"]) {
//        return [VKVideoMTL class];
//    }
    
    return nil;
}

@end
