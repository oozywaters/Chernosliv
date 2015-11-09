//
//  MKCPhotoAttachmentViewController.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 18/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCPhotoAttachmentViewModel.h"
#import "MKCAttachmentViewController.h"

@interface MKCPhotoAttachmentViewController : MKCAttachmentViewController

//@property (nonatomic, strong) UIImageView *contentView;

- (instancetype)initWithViewModel:(MKCPhotoAttachmentViewModel *)viewModel;

@end