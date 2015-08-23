//
//  MKCAttachmentsPresenter.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 20/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCAttachmentsPresenter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "VKAttachment.h"
#import "VKPhotoMTL.h"
#import "MKCPhotoAttachmentViewModel.h"

@interface MKCAttachmentsPresenter ()

@property (nonatomic, strong) VKPost *post;
@property (nonatomic, strong) NSArray *attachments;

@end

@implementation MKCAttachmentsPresenter

- (instancetype)initWithPost:(VKPost *)post {
    self = [super init];
    if (self) {
        _post = post;
        _attachments = [[post.attachments.rac_sequence map:^id(VKAttachment *attachment) {
            if ([attachment isKindOfClass:[VKPhotoMTL class]]) {
                return [[MKCPhotoAttachmentViewModel alloc] initWithModel:(VKPhotoMTL *)attachment];
            }
            return nil;
        }] array];
    }
    return self;
}

- (void)configurePresenterWithUserInterface:(UIViewController<MKCAttachmentsViewInterface> *)userInterface {
    self.userInterface = userInterface;
    [self.userInterface updateAttachmentsData:self.attachments];
}

- (void)attachmentsTapped:(NSArray *)attachments {
    
}

@end
