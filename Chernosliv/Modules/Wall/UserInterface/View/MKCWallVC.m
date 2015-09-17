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
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface MKCWallVC () <MKCWallTableControllerDelegate>

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
        self.contentView = [MKCTableContainerView containerWithTableViewStyle:UITableViewStyleGrouped];
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

#pragma mark - DZNEmptyDataSetSource

//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return [UIImage imageNamed:@"CommentIcon"];
//}

//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = @"This allows you to share photos from your library and save photos to your camera roll.";
//    
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//    
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
//                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
//                                 NSParagraphStyleAttributeName: paragraph};
//    
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}

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