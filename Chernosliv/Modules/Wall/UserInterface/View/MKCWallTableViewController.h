//
//  WallTableViewController.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallViewInterface.h"
#import "PostTableViewCell.h"
#import "MKCWallModuleInterface.h"

@interface MKCWallTableViewController : UITableViewController <MKCWallViewInterface>

@property (nonatomic, weak) id<MKCWallModuleInterface> eventHandler;
@property (nonatomic, strong, readonly) PostTableViewCell *currentCell;
@property (nonatomic, strong) UIImageView *tappedImage;

@end
