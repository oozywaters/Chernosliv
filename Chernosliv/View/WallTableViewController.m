//
//  WallTableViewController.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "WallTableViewController.h"
#import "PostTableViewCell.h"
#import "WallViewModel.h"
#import "VKPost.h"
#import "TableViewBindingHelper.h"
#import <SVPullToRefresh/SVPullToRefresh.h>

@interface WallTableViewController ()

@property (nonatomic, strong) WallViewModel *viewModel;
@property (nonatomic, strong) ObservableMutableArray *someArray;

@property (nonatomic, strong) TableViewBindingHelper *bindingHelper;

@end

@implementation WallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
//    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    _viewModel = [WallViewModel new];
    
    self.refreshControl.rac_command = [self.viewModel loadNextPage];
    
    _bindingHelper = [TableViewBindingHelper bindingHelperForTableView:self.tableView
                                         sourceSignal:RACObserve(self.viewModel, posts)
                                     selectionCommand:nil
                                       cellIdentifier:@"Post Cell"];
    _bindingHelper.delegate = self;
    
    // Infinite scroll functionality
    @weakify(self)
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        @strongify(self)
        [[[self.viewModel loadNextPage] execute:nil] subscribeCompleted:^{
            [self.tableView.infiniteScrollingView stopAnimating];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end