//
//  WallTableViewController.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallVC.h"
#import "MKCTableContainerView.h"
#import "MKCWallTableController.h"



#import "PostViewModel.h"
#import "MKCWallDataSource.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface MKCWallVC () <MKCWallTableControllerDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) MKCTableContainerView *contentView;
@property (nonatomic, strong) MKCWallTableController *controller;

//@property (nonatomic, strong) MKCWallDataSource *dataSource;
//@property (nonatomic, strong) TableViewBindingHelper *bindingHelper;
//@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation MKCWallVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentView = [MKCTableContainerView containerWithTableViewStyle:UITableViewStylePlain];
        self.controller = [[MKCWallTableController alloc] initWithTableView:self.contentView.tableView];
        self.controller.delegate = self;
        [self setNeedsStatusBarAppearanceUpdate];
    }
    return self;
}

- (void)loadView {
    self.view = self.contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    self.progressHUD.labelText = @"Загрузка";
    
//    self.tableView.emptyDataSetDelegate = self;
//    self.tableView.emptyDataSetSource = self;
//    
//    // A little trick for removing the cell separators
//    self.tableView.tableFooterView = [UIView new];
//    

//    
//    // Infinite scroll functionality
//    @weakify(self)
//    [self.tableView addInfiniteScrollingWithActionHandler:^{
//        @strongify(self)
//        [self.eventHandler loadNextPage];
//    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)pageLoaded {
//    if (self.tableView.emptyDataSetVisible) {
//        [self.tableView reloadEmptyDataSet];
//    }
//    [self.progressHUD hide:YES];
//    [self.tableView.infiniteScrollingView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

# pragma mark - MKCWallViewInterface

- (void)updateDataSource:(MKCWallDataSource *)dataSource {
    [self.controller updateDataSource:dataSource];
}

- (void)attachmentsTappedWithView:(UIView *)tappedView {
    self.tappedView = tappedView;
}

# pragma mark - MKCWallTableControllerDelegate

- (void)itemSelected:(PostViewModel *) model {
    [self.eventHandler viewCommentsWithModel:model];
}

@end