//
//  MKCAttachmentViewController.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 09/11/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

@class VKAttachment;

@interface MKCAttachmentViewController : UIViewController

@property (nonatomic, strong) UIImageView *contentView;

- (instancetype)initWithAttachment:(VKAttachment *)attachment;
- (void)saveAttachment;

@end
