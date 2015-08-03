//
//  AttachmentsViewModel.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 27.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "AttachmentsViewModel.h"

@interface AttachmentsViewModel ()

@property (nonatomic, strong) NSArray *attachments;
@property (nonatomic, weak) id<ViewModelServices> services;

@end

@implementation AttachmentsViewModel

- (instancetype)initWithAttachments:(NSArray *)attachments services:(id<ViewModelServices>)services {
    self = [super init];
    if (self) {
        _attachments = attachments;
        _services = services;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
}

@end
