//
//  MKCPhotoAttachmentViewModel.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 17/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCPhotoAttachmentViewModel.h"
#import "VKPhotoMTL.h"

@interface MKCPhotoAttachmentViewModel ()

@property (nonatomic, strong) VKPhotoMTL *model;

@end

@implementation MKCPhotoAttachmentViewModel

- (instancetype)initWithModel:(VKPhotoMTL *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _width = self.model.size.width;
    _height = self.model.size.height;
    _url = self.model.url;
}

@end
