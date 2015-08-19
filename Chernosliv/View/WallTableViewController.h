//
//  WallTableViewController.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallViewModel.h"
#import "PostTableViewCell.h"

@interface WallTableViewController : UITableViewController

@property (nonatomic, strong, readonly) PostTableViewCell *currentCell;

- (instancetype)initWithViewModel:(WallViewModel *)viewModel;

@end
