//
//  MKCPhotoAttachmentViewController.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 18/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCPhotoAttachmentViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MKCPhotoAttachmentViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) MKCPhotoAttachmentViewModel *viewModel;

@end

@implementation MKCPhotoAttachmentViewController

- (instancetype)initWithViewModel:(MKCPhotoAttachmentViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        _contentView = [UIImageView new];
        [self initialize];
    }
    return self;
}

- (void)initialize {
    UIScrollView *zoomScrollView = [UIScrollView new];
    zoomScrollView.maximumZoomScale = 2.0;
    zoomScrollView.minimumZoomScale = 1.0;
    
    _contentView.contentMode = UIViewContentModeScaleToFill;
    
    self.view = zoomScrollView;
    [zoomScrollView addSubview:self.contentView];
    zoomScrollView.delegate = self;
    
    CGFloat aspectRatio = self.viewModel.width / self.viewModel.height;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(self.view.mas_width);
        make.height.lessThanOrEqualTo(self.view.mas_height);
        make.width.equalTo(self.contentView.mas_height).multipliedBy(aspectRatio);
        make.center.equalTo(self.view);
    }];
    
    [self.contentView sd_setImageWithURL:self.viewModel.url];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.contentView;
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
