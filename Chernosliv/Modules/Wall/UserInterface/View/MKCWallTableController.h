//
//  MKCWallTableController.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 16/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "ANTableController.h"

@class MKCWallDataSource;
@class PostViewModel;

@protocol MKCWallTableControllerDelegate <NSObject>

- (void)itemSelected:(PostViewModel *)viewModel;

@end

@interface MKCWallTableController : ANTableController

@property (nonatomic, weak) id<MKCWallTableControllerDelegate> delegate;

- (void)updateDataSource:(MKCWallDataSource *)dataSource;
- (void)wallPageLoaded;

@end
