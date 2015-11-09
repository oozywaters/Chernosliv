//
//  MKCAttachmentsPresenter.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 20/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCAttachmentsPresenter.h"
#import "VKAttachment.h"
//#import "MKCAttachmentViewModel.h"
#import "MKCAttachmentViewController.h"

@interface MKCAttachmentsPresenter ()

@property (nonatomic, strong) MKCVKPost *post;
@property (nonatomic, strong) NSArray *attachments;

@end

@implementation MKCAttachmentsPresenter

- (instancetype)initWithPost:(MKCVKPost *)post {
    self = [super init];
    if (self) {
        _post = post;
        _attachments = [[post.attachments.rac_sequence map:^id(VKAttachment *attachment) {
            return [[MKCAttachmentViewController alloc] initWithAttachment:attachment];
//            return [[MKCAttachmentViewModel alloc] initWithAttachment:attachment];
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
