//
//  MKCWallTableController.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 16/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallTableController.h"
#import "MKCWallDataSource.h"
#import "PostTableViewCell.h"
#import "PostViewModel.h"

@implementation MKCWallTableController

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super initWithTableView:tableView];
    if (self) {
//        [self registerCellClass:[PostTableViewCell class] forModelClass:[PostViewModel class]];
        [self registerCellNib:@"PostTableViewCell" forModelClass:[PostViewModel class]];
        tableView.rowHeight = 500;
    }
    return self;
}

- (void)updateDataSource:(MKCWallDataSource *)dataSource {
    self.storage = dataSource.storage;
}

@end
