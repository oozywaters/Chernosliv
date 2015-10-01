//
//  MKCTableContainerView.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 16/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCTableContainerView.h"
#import <ANTableViews/ANTableView.h>

@implementation MKCTableContainerView

+ (instancetype)containerWithTableViewStyle:(UITableViewStyle)style
{
    return [[self alloc] initWithStyle:style];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    self.backgroundColor = [UIColor an_colorWithHexString:@"#FFFFFF"];
    if (self)
    {
        ANTableView* tableView = [[ANTableView alloc] initWithFrame:CGRectZero style:style];
        [tableView setupAppearance];
        _tableView = tableView;
        _tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
        [self addSubview:_tableView];
        
        UIEdgeInsets padding = UIEdgeInsetsMake(20, 0, 0, 0);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(padding);
        }];
    }
    return self;
}

@end
