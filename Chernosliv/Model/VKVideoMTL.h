//
//  VKVideoMTL.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 01.08.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "VKAttachment.h"

@interface VKVideoMTL : VKAttachment

@property (nonatomic, strong) NSURL *thumbnail;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *identifier;

@end
