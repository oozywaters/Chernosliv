//
//  AttachmentsViewModel.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 27.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "AttachmentsViewModel.h"
#import "VKAttachment.h"
#import "VKPhotoMTL.h"
#import "MKCPhotoAttachmentViewModel.h"
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
//#import "VKPhotoMTL.h"

@interface AttachmentsViewModel ()

@property (nonatomic, weak) id<ViewModelServices> services;

@end

@implementation AttachmentsViewModel

- (instancetype)initWithAttachments:(NSArray *)attachments services:(id<ViewModelServices>)services {
    self = [super init];
    if (self) {
        _services = services;
        _attachments = [attachments linq_select:^id(VKAttachment *attachment) {
            if ([attachment isKindOfClass:[VKPhotoMTL class]]) {
                return [[MKCPhotoAttachmentViewModel alloc] initWithModel:(VKPhotoMTL *) attachment];
            }
            return nil;
        }];
        [self initialize];
    }
    return self;
}

- (void)initialize {
}

- (NSUInteger)getAttachmentsCount {
    return self.attachments.count;
}

- (NSURL *)urlForAttachmentAtIndex:(NSUInteger)index {
    if (index <= [self getAttachmentsCount]) {
        VKPhotoMTL *photo = [self.attachments objectAtIndex:index];
        return photo.url;
    } else {
        return nil;
    }
}

@end
