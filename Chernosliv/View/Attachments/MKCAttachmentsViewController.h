//
//  MKCAttachmentsViewController.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 18/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttachmentsViewModel.h"

@interface MKCAttachmentsViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *pageViews;

- (instancetype)initWithViewModel:(AttachmentsViewModel *)viewModel;

@end
