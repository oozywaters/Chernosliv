//
//  VKAttachment.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 19.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface VKAttachment : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *type;

@end
