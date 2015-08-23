//
//  MKCPhotoAttachmentViewModel.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 17/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class VKPhotoMTL;

@interface MKCPhotoAttachmentViewModel : NSObject

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic, strong) NSURL *url;

- (instancetype)initWithModel:(VKPhotoMTL *)model;

@end
