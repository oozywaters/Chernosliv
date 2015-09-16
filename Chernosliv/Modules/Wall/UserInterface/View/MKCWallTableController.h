//
//  MKCWallTableController.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 16/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "ANTableController.h"

@class MKCWallDataSource;

@interface MKCWallTableController : ANTableController

- (void)updateDataSource:(MKCWallDataSource *)dataSource;

@end
