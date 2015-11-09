//
//  MKCAttachmentViewController.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 09/11/15.
//  Copyright © 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCAttachmentViewController.h"

#import "VKPhotoMTL.h"
#import "VKVideoMTL.h"
#import "MKCPhotoAttachmentViewModel.h"
#import "MKCVideoAttachmentViewModel.h"
#import "MKCPhotoAttachmentViewController.h"
#import "MKCVideoAttachmentViewController.h"


@interface MKCAttachmentViewController ()

@end

@implementation MKCAttachmentViewController

- (instancetype)initWithAttachment:(VKAttachment *)attachment {
    if ([attachment isKindOfClass:[VKPhotoMTL class]]) {
        MKCPhotoAttachmentViewModel *viewModel = [[MKCPhotoAttachmentViewModel alloc] initWithModel:(VKPhotoMTL *)attachment];
        return [[MKCPhotoAttachmentViewController alloc] initWithViewModel:viewModel];
    } else if ([attachment isKindOfClass:[VKVideoMTL class]]) {
        MKCVideoAttachmentViewModel *viewModel = [[MKCVideoAttachmentViewModel alloc] initWithModel:(VKVideoMTL *)attachment];
        return [[MKCVideoAttachmentViewController alloc] initWithViewModel:viewModel];
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
