//
//  MKCTableContainerView.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 16/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@interface MKCTableContainerView : UIView

@property (nonatomic, strong) UITableView* tableView;

+ (instancetype)containerWithTableViewStyle:(UITableViewStyle)style;

- (instancetype)initWithStyle:(UITableViewStyle)style NS_DESIGNATED_INITIALIZER;

@end
