//
//  MKCCommentsViewController.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsViewInterface.h"
#import "MKCCommentsModuleInterface.h"

@interface MKCCommentsViewController : UITableViewController <MKCCommentsViewInterface>

@property (nonatomic, strong) id<MKCCommentsModuleInterface> eventHandler;

@end
