//
//  MKCVideoAttachmentViewController.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 09/11/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCVideoAttachmentViewModel.h"
#import "MKCAttachmentViewController.h"

@interface MKCVideoAttachmentViewController : MKCAttachmentViewController

//@property (nonatomic, strong) UIImageView *contentView;

- (instancetype)initWithViewModel:(MKCVideoAttachmentViewModel *)viewModel;

@end
