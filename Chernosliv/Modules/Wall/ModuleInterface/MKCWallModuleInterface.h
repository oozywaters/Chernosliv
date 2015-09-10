//
//  MKCWallModuleInterface.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol MKCWallModuleDelegate;

@class MKCVKPost;

@protocol MKCWallModuleInterface <NSObject>

@property (nonatomic, strong) id<MKCWallModuleDelegate> wallModuleDelegate;
@property (nonatomic, strong) RACCommand *viewComments;
@property (nonatomic, strong) RACCommand *viewAttachments;

- (void)loadNextPage;

@end
