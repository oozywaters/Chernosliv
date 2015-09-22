//
//  MKCCommentsTableContainerView.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 22/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

@interface MKCCommentsTableContainerView : UIView

@property (nonatomic, strong) UITableView *tableView;

+ (instancetype)containerWithTableViewStyle:(UITableViewStyle)style;

- (instancetype)initWithStyle:(UITableViewStyle)style NS_DESIGNATED_INITIALIZER;
- (void)setHeaderViewWithImageURL:(NSURL *)imageURL;

@end
