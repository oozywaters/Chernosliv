//
//  WallTableViewController.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallTableViewController.h"
#import "PostViewModel.h"
#import "MKCWallDataSource.h"
#import "TableViewBindingHelper.h"
#import <SVPullToRefresh/SVPullToRefresh.h>

@interface MKCWallTableViewController () <PostTableViewCellDelegate>

@property (nonatomic, strong) MKCWallDataSource *dataSource;
@property (nonatomic, strong) TableViewBindingHelper *bindingHelper;


@end

@implementation MKCWallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"PostTableViewCell" bundle:nil];
    
    _bindingHelper = [TableViewBindingHelper bindingHelperForTableView:self.tableView
                                                          sourceSignal:RACObserve(self.dataSource, posts)
                                                      selectionCommand:self.eventHandler.viewComments
                                                          templateCell:nib];
    _bindingHelper.delegate = self;
    
    // Infinite scroll functionality
    @weakify(self)
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        @strongify(self)
        [self.eventHandler loadNextPage];
    }];
}

- (void)pageLoaded {
    [self.tableView.infiniteScrollingView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44;
//}

# pragma mark - PostTableViewCellDelegate

- (void)postTableViewCellAttachmentsTapped:(UITableViewCell *)cell {
    _currentCell = (PostTableViewCell *)cell;
}

- (void)postTableViewCellCommentsTapped:(UITableViewCell *)cell {
    _currentCell = (PostTableViewCell *)cell;
}

# pragma mark - MKCWallViewInterface

- (void)updateDataSource:(MKCWallDataSource *)dataSource {
    self.dataSource = dataSource;
}

# pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    PostViewModel *viewModel = [self.dataSource objectAtIndex:indexPath.row];
//    CGFloat height = [viewModel calculateViewHeightForWidth:self.tableView.bounds.size.width];
//    //    return UITableViewAutomaticDimension;
//    //    return 400;
//    return height;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostViewModel *viewModel = [self.dataSource objectAtIndex:indexPath.row];
    CGFloat height = [viewModel calculateViewHeightForWidth:self.tableView.bounds.size.width];
    return height;
}

@end