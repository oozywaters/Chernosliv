//
//  MKCVideoAttachmentViewModel.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 09/11/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVideoAttachmentViewModel.h"
#import "VKVideoMTL.h"

@interface MKCVideoAttachmentViewModel ()

@property (nonatomic, strong) VKVideoMTL *model;

@end

@implementation MKCVideoAttachmentViewModel

- (instancetype)initWithModel:(VKVideoMTL *)model {
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
