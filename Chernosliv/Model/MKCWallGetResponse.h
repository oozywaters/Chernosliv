//
//  MKCWallGetResponse.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 06/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MKCWallGetResponse : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) NSMutableDictionary *profiles;
@property (nonatomic, strong) NSMutableDictionary *groups;
@property (nonatomic) NSUInteger totalPostsCount;

@end
