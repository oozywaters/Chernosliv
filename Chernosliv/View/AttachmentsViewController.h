//
//  AttachmentsViewController.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 27.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AttachmentsViewModel;

@interface AttachmentsViewController : UIViewController

- (instancetype)initWithViewModel:(AttachmentsViewModel *)viewModel;

@end
