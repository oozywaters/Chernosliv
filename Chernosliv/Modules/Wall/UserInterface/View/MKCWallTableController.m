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
        [self registerCellNib:@"PostTableViewCell" forModelClass:[PostViewModel class]];
    }
    return self;
}

- (void)updateDataSource:(MKCWallDataSource *)dataSource {
    self.storage = dataSource.storage;
}

# pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostViewModel *postViewModel = [self.storage objectAtIndexPath:indexPath];
    CGFloat height = [postViewModel calculateViewHeightForWidth:tableView.bounds.size.width];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PostViewModel *viewModel = [self.storage objectAtIndexPath:indexPath];
    [self.delegate itemSelected:viewModel];
}


@end
