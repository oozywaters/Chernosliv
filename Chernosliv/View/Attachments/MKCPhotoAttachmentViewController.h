//
//  MKCPhotoAttachmentViewController.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 18/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKCPhotoAttachmentViewModel.h"

@interface MKCPhotoAttachmentViewController : UIViewController

@property (nonatomic, strong) UIImageView *contentView;

- (instancetype)initWithViewModel:(MKCPhotoAttachmentViewModel *)viewModel;

@end