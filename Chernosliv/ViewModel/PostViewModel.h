//
//  PostViewModel.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 29.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKPost.h"
#import "ViewModelServices.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface PostViewModel : NSObject

@property (nonatomic, strong) NSString *postText;

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic) CGFloat imageWidth;
@property (nonatomic) CGFloat imageHeight;

@property (nonatomic) NSUInteger attachmentsCount;
@property (nonatomic, strong) RACSignal *postAttachmentTap;

- (instancetype)initWithPost:(VKPost *)post services:(id<ViewModelServices>)services;

- (RACCommand *)showComments;

- (void)showAttachments;

@end
