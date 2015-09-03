//
//  VKPost.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Mantle.h>

@interface VKPost : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *postId;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray *attachments;

@end
