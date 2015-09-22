//
//  MKCCommentsViewInterface.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class MKCCommentsDataSource;

@protocol MKCCommentsViewInterface <NSObject>

- (void)updateDataSource:(MKCCommentsDataSource *)dataSource;
- (void)setHeaderViewWithImageURL:(NSURL *)imageURL;

@end
