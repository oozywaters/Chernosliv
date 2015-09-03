//
//  MKCVKComment.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MKCVKComment : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *authorId;
@property (nonatomic, strong) NSString *text;

@end
