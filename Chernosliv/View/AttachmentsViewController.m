//
//  AttachmentsViewController.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 27.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "AttachmentsViewController.h"
#import "AttachmentsViewModel.h"

@interface AttachmentsViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) AttachmentsViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIScrollView *pagingScrollView;

@end

@implementation AttachmentsViewController

- (instancetype)initWithViewModel:(AttachmentsViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    pagingScrollView.contentSize = CGSizeMake(pagingScrollViewFrame.size.width, pagingScrollViewFrame.size.height);
//    self.view = pagingScrollView;
////    self.scrollView.contentSize 
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
