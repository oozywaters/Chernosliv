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
#import <Masonry/Masonry.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface MKCWallTableViewController () <UITableViewDelegate, PostTableViewCellDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) MKCWallDataSource *dataSource;
@property (nonatomic, strong) TableViewBindingHelper *bindingHelper;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation MKCWallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Загрузка";
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
    
    UINib *nib = [UINib nibWithNibName:@"PostTableViewCell" bundle:nil];
    
    _bindingHelper = [TableViewBindingHelper bindingHelperForTableView:self.tableView
                                                          sourceSignal:RACObserve(self.dataSource, posts)
                                                      selectionCommand:self.eventHandler.viewComments
                                                          templateCell:nib];
    
//    [self setupStatusBar];
    _bindingHelper.delegate = self;
//    _bindingHelper.delegate = (id<UITableViewDelegate>)_myBar.behaviorDefiner;
    
    // Infinite scroll functionality
    @weakify(self)
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        @strongify(self)
        [self.eventHandler loadNextPage];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)pageLoaded {
    if (self.tableView.emptyDataSetVisible) {
        [self.tableView reloadEmptyDataSet];
    }
    [self.progressHUD hide:YES];
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
    _tappedImage = _currentCell.postImage;
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
//    return UITableViewAutomaticDimension;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - DZNEmptyDataSetSource

//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return [UIImage imageNamed:@"CommentIcon"];
//}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"This allows you to share photos from your library and save photos to your camera roll.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end