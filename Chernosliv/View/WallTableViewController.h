//
//  WallTableViewController.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WallViewModel;

@interface WallTableViewController : UITableViewController

- (instancetype)initWithViewModel:(WallViewModel *)viewModel;

@end
