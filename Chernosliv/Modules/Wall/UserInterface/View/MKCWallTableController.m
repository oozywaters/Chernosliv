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
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface MKCWallTableController () <DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@end

@implementation MKCWallTableController

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super initWithTableView:tableView];
    if (self) {
        [self registerCellNib:@"PostTableViewCell" forModelClass:[PostViewModel class]];
        
        [self.tableView setSeparatorColor:[UIColor an_colorWithHexString:@"#D9D9D9"]];
        
//        self.tableView.emptyDataSetDelegate = self;
//        self.tableView.emptyDataSetSource = self;
//        self.tableView.tableFooterView = [UIView new];
    }
    return self;
}

- (void)updateDataSource:(MKCWallDataSource *)dataSource {
    self.storage = dataSource.storage;
}

- (void)wallPageLoaded {
    if (self.tableView.emptyDataSetVisible) {
        [self.tableView reloadEmptyDataSet];
    }
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostViewModel *postViewModel = [self.storage objectAtIndexPath:indexPath];
    CGFloat height = [postViewModel calculateViewHeightForWidth:tableView.bounds.size.width];
    return height;
//    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PostViewModel *viewModel = [self.storage objectAtIndexPath:indexPath];
    [self.delegate itemSelected:viewModel];
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"bird"];
}

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

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

# pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    ANMemoryStorage *storage = (ANMemoryStorage *)self.storage;
    if ([storage hasItems]) {
        return NO;
    } else {
        return YES;
    }
}

@end
