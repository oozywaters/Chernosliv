//
//  MKCVideoAttachmentViewModel.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 09/11/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class VKVideoMTL;

@interface MKCVideoAttachmentViewModel : NSObject

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic, strong) NSURL *url;

- (instancetype)initWithModel:(VKVideoMTL *)model;

@end
