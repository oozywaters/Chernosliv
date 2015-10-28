//
//  MKCCommentsViewController.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsViewController.h"
//#import "MKCCommentsHeaderView.h"
//#import "MKCCommentsPostDetailsTableViewCell.h"
//#import "MKCCommentsPost.h"
//#import <SDWebImage/UIImageView+WebCache.h>
//#import <SDWebImage/UIImage+MultiFormat.h>

#import "MKCCommentsTableController.h"
#import <SVPullToRefresh/SVPullToRefresh.h>

@interface MKCCommentsViewController () <MKCCommentsTableControllerDelegate>

//@property (nonatomic, strong, readonly) NSString *postDetailsCellReuseIdentifier;
//@property (nonatomic, strong, readonly) NSString *commentsCellReuseIdentifier;
//
//@property (nonatomic, strong) MKCCommentsPost *post;
//
//@property (nonatomic, strong, readonly) UIView *headerView;
//
//@property (nonatomic, strong) CAGradientLayer *gradient;


@property (nonatomic) BOOL isHeaderViewSet;
@property (nonatomic, strong) MKCCommentsTableController *controller;

@end

@implementation MKCCommentsViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.controller = [[MKCCommentsTableController alloc] initWithTableView:self.tableView];
        self.controller.delegate = self;
        [self setNeedsStatusBarAppearanceUpdate];
        self.isHeaderViewSet = NO;
        
        @weakify(self);
        [self.tableView addInfiniteScrollingWithActionHandler:^{
            @strongify(self);
            [self.eventHandler scrollBottomReached];
//            self.eventHandler 
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self.controller updateHeaderView];
//
//    [self setUpCells];
//    
//    [self updateHeaderView];
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor redColor];
//    [self.tableView addSubview:view];
//    
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tableView.mas_top);
//        make.right.equalTo(self.tableView.mas_right);
//        make.left.equalTo(self.tableView.mas_left);
//    }];
//    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.backgroundColor = [UIColor an_colorWithHexString:@"#627797"];
//    if (self.isHeaderViewSet) {
////        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
////                                                      forBarMetrics:UIBarMetricsDefault];
//        self.navigationController.navigationBar.translucent = YES;
////        self.navigationController.view.backgroundColor = [UIColor clearColor];
////        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    } else {
//        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar lt_reset];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.isHeaderViewSet) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

#pragma mark - MKCCommentsViewInterface

- (void)updateDataSource:(MKCCommentsDataSource *)dataSource {
    [self.controller updateDataSource:dataSource];
}

- (void)setHeaderViewWithImageURL:(NSURL *)imageURL {
    self.isHeaderViewSet = YES;
    [self.controller setHeaderViewWithImageURL:imageURL];
}

- (void)commentsLoaded {
    NSLog(@"Comments loaded");
    [self.tableView.infiniteScrollingView stopAnimating];
}

- (void)nothingToLoad {
    NSLog(@"Nothong to load");
    [self.tableView.infiniteScrollingView stopAnimating];
    self.tableView.showsInfiniteScrolling = NO;
}

#pragma mark - MKCCommentsTableControllerDelegate
#define NAVBAR_CHANGE_POINT -139

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    UIColor *color = [UIColor an_colorWithHexString:@"#627797"];
    UIColor *color = [UIColor an_colorWithHexString:@"#4A90E2"];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.navigationController.navigationBar lt_setTranslationY:(75 * progress)];
    [self.navigationController.navigationBar lt_setElementsAlpha:(1-progress)];
}

@end
