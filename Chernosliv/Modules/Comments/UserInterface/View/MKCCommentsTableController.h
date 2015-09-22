//
//  MKCCommentsTableController.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 21/09/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "ANTableController.h"

@class MKCCommentsDataSource;

@interface MKCCommentsTableController : ANTableController

- (void)updateDataSource:(MKCCommentsDataSource *)dataSource;
- (void)setHeaderViewWithImageURL:(NSURL *)imageURL;
- (void)updateHeaderView;

@end
