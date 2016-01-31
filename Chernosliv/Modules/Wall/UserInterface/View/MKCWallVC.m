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

@interface MKCWallVC () <MKCWallTableControllerDelegate>

@property (nonatomic, strong) MKCTableContainerView *contentView;
@property (nonatomic, strong) MKCWallTableController *controller;

//@property (nonatomic, strong) MKCWallDataSource *dataSource;
//@property (nonatomic, strong) TableViewBindingHelper *bindingHelper;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation MKCWallVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentView = [MKCTableContainerView containerWithTableViewStyle:UITableViewStylePlain];
        self.controller = [[MKCWallTableController alloc] initWithTableView:self.contentView.tableView];
        self.controller.delegate = self;
        [self setNeedsStatusBarAppearanceUpdate];
        
        @weakify(self);
        [self.contentView.tableView addInfiniteScrollingWithActionHandler:^{
            @strongify(self);
            [self.eventHandler loadNextPage];
        }];
//        [self.eventHandler.pageLoadingSignal subscribeNext:^{
//            NSLog(@"Page Loading");
//        }];
    }
    return self;
}

- (void)loadView {
    self.view = self.contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = NSLocalizedString(@"Loading", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
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

- (void)pageLoaded {
    [self.progressHUD hide:YES];
    [self.controller wallPageLoaded];
    [self.contentView.tableView.infiniteScrollingView stopAnimating];
    //    if (self.tableView.emptyDataSetVisible) {
    //        [self.tableView reloadEmptyDataSet];
    //    }
    //    [self.progressHUD hide:YES];
    //    [self.tableView.infiniteScrollingView stopAnimating];
}

- (void)nothingToLoad {
    [self.progressHUD hide:YES];
    [self.contentView.tableView.infiniteScrollingView stopAnimating];
    self.contentView.tableView.showsInfiniteScrolling = NO;
}

# pragma mark - MKCWallTableControllerDelegate

- (void)itemSelected:(PostViewModel *) model {
    [self.eventHandler viewCommentsWithModel:model];
}

@end