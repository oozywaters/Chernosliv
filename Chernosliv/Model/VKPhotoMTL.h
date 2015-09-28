//
//  VKPhotoMTL.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 19.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "VKAttachment.h"
#import <UIKit/UIKit.h>

@interface VKPhotoMTL : VKAttachment

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL *thumbnail;
@property (nonatomic) CGSize size;

@end
