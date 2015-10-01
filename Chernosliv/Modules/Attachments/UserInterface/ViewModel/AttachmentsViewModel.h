//
//  AttachmentsViewModel.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 27.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@interface AttachmentsViewModel : NSObject

@property (nonatomic, strong) NSArray *attachments;

- (instancetype)initWithAttachments:(NSArray *)attachments;
- (NSUInteger)getAttachmentsCount;
- (NSURL *)urlForAttachmentAtIndex:(NSUInteger)index;

@end
