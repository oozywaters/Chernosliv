//
//  MKCCommentsTableController.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 21/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsTableController.h"
#import "MKCCommentsDataSource.h"
#import "MKCCommentsPostDetailsTableViewCell.h"
#import "MKCCommentsPostDetailsViewModel.h"
#import "MKCCommentViewModel.h"
#import "MKCCommentsHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>

static const CGFloat kTableHeaderHeight = 75.0;

@interface MKCCommentsTableController ()

@property (nonatomic, strong) UIView *headerView;

@end

@implementation MKCCommentsTableController

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super initWithTableView:tableView];
    if (self) {
        [self registerCellNib:@"MKCCommentsPostDetailsTableViewCell"
                forModelClass:[MKCCommentsPostDetailsViewModel class]];
        [self registerCellNib:@"MKCCommentsTableViewCell"
                forModelClass:[MKCCommentViewModel class]];
        self.tableView.backgroundColor = [UIColor an_colorWithHexString:@"#FAFAFA"];
    }
    return self;
}

- (void)updateDataSource:(MKCCommentsDataSource *)dataSource {
    self.storage = dataSource.storage;
}

- (void)setHeaderViewWithImageURL:(NSURL *)imageURL {
    UIImageView *headerImageView = [UIImageView new];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    //    [self.headerView addSubview:headerImage];
    //    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.headerView);
    //    }];
    [headerImageView sd_setImageWithURL:imageURL];
    //    UIImage *img = [UIImage imageNamed:@"bird"];
    //    [headerImage setImage:img];
    
    
    CGFloat headerWidth = self.tableView.bounds.size.width;
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerWidth, kTableHeaderHeight)];
    _headerView.clipsToBounds = YES;
    //    _headerView.backgroundColor = [UIColor redColor];
    //    _headerView = [UIView new];
    //    self.tableView.tableHeaderView = _headerView;
    [self.tableView addSubview:self.headerView];
    
    [_headerView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headerView);
    }];
    
    MKCCommentsHeaderView *gradient = [[MKCCommentsHeaderView alloc] initWithFrame:_headerView.frame];
    [_headerView addSubview:gradient];
    [gradient mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headerView);
    }];
    //
    self.tableView.contentInset = UIEdgeInsetsMake(kTableHeaderHeight, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -kTableHeaderHeight);
}

- (void)updateHeaderView {
    if (self.headerView) {
        CGRect headerRect = CGRectMake(0, -kTableHeaderHeight, self.tableView.bounds.size.width, kTableHeaderHeight);
        if (self.tableView.contentOffset.y < -kTableHeaderHeight) {
            headerRect.origin.y = self.tableView.contentOffset.y;
            headerRect.size.height = -self.tableView.contentOffset.y;
        }
        self.headerView.frame = headerRect;
//        [self.headerView setNeedsUpdateConstraints];
        [self.headerView.layer setNeedsLayout];
    }
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
//    return 400;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateHeaderView];
    [self.delegate scrollViewDidScroll:scrollView];
}

@end
