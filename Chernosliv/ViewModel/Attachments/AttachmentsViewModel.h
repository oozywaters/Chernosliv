//
//  AttachmentsViewModel.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 27.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModelServices.h"

@interface AttachmentsViewModel : NSObject

@property (nonatomic, strong) NSArray *attachments;

- (instancetype)initWithAttachments:(NSArray *)attachments services:(id<ViewModelServices>)services;
- (NSUInteger)getAttachmentsCount;
- (NSURL *)urlForAttachmentAtIndex:(NSUInteger)index;

@end
