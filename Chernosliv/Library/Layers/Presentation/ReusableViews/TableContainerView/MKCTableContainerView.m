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
//    self.backgroundColor = [UIColor whiteColor];
    if (self)
    {
        ANTableView* tableView = [[ANTableView alloc] initWithFrame:CGRectZero style:style];
        [tableView setupAppearance];
        _tableView = tableView;
        [self addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end
