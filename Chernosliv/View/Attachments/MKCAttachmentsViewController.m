//
//  MKCAttachmentsViewController.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 18/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCAttachmentsViewController.h"
#import "MKCPhotoAttachmentViewModel.h"
#import "MKCPhotoAttachmentViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@interface MKCAttachmentsViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UIScrollView *pagingScrollView;
@property (nonatomic, strong) AttachmentsViewModel *viewModel;

@end

@implementation MKCAttachmentsViewController

- (instancetype)initWithViewModel:(AttachmentsViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        _pageViews = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUInteger attachmentsCount = [self.viewModel getAttachmentsCount];
//    
//    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * attachmentsCount,
//                                             self.view.frame.size.height);
    
    [self.view addSubview:self.pagingScrollView];
    
    UIView *previousView = nil;
    for (int i = 0; i < attachmentsCount; i++) {
        MKCPhotoAttachmentViewModel *pvm = self.viewModel.attachments[i];
        MKCPhotoAttachmentViewController *pvc = [[MKCPhotoAttachmentViewController alloc] initWithViewModel:pvm];
        
        [_pageViews addObject:pvc.contentView];
        
        [self addChildViewController:pvc];
        [self.scrollView addSubview:pvc.view];
        
        if (!previousView) {
            [pvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.scrollView.mas_left).with.offset(10);
            }];
        } else {
            [pvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(previousView.mas_right).with.offset(20);
            }];
        }
        
        [pvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view.mas_width);
            make.height.equalTo(self.view.mas_height);
            make.top.equalTo(self.view.mas_top);
        }];
        [pvc didMoveToParentViewController:self];
        previousView = pvc.view;
    }
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(previousView.mas_right).with.offset(10);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidLayoutSubviews {
//    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 10,
//                                             self.view.frame.size.height);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
