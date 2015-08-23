//
//  MKCAttachmentsViewController.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 18/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCAttachmentsModuleInterface.h"
#import "MKCAttachmentsViewInterface.h"

@interface MKCAttachmentsViewController : UIViewController <MKCAttachmentsViewInterface>

@property (nonatomic, weak) id<MKCAttachmentsModuleInterface> eventHandler;
@property (nonatomic, strong) NSMutableArray *pageViews;

@end
