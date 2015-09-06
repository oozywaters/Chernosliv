//
//  MKCWallViewInterface.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 20/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class MKCWallDataSource;

@protocol MKCWallViewInterface <NSObject>

- (void)updateDataSource:(MKCWallDataSource *)dataSource;
- (void)pageLoaded;

@end
