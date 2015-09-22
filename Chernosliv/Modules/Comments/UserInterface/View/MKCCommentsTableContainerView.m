//
//  MKCCommentsTableContainerView.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 22/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsTableContainerView.h"
#import <ANTableViews/ANTableView.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MKCCommentsTableContainerView

+ (instancetype)containerWithTableViewStyle:(UITableViewStyle)style
{
    return [[self alloc] initWithStyle:style];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    self.backgroundColor = [UIColor an_colorWithHexString:@"#FAFAFA"];
    if (self) {
        ANTableView* tableView = [[ANTableView alloc] initWithFrame:CGRectZero style:style];
        [tableView setupAppearance];
        _tableView = tableView;
        _tableView.clipsToBounds = NO;
        
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
    }
    return self;
}

@end
