//
//  MKCWallModuleInterface.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@protocol MKCWallModuleDelegate;

@class MKCVKPost;
@class PostViewModel;

@protocol MKCWallModuleInterface <NSObject>

@property (nonatomic, strong) id<MKCWallModuleDelegate> wallModuleDelegate;

- (void)viewAttachmentsWithModel:(PostViewModel *)viewModel;
- (void)viewCommentsWithModel:(PostViewModel *)viewModel;

- (void)loadNextPage;

@end
