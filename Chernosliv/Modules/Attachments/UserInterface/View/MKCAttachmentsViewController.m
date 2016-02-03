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
#import "VKAttachment.h"
#import "VKPhotoMTL.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "MKCAttachmentViewController.h"

@interface MKCAttachmentsViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *pagingScrollView;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGestureRecoginzer;
@property (nonatomic, strong) MKCAttachmentsGradientView *gradientView;
@property (nonatomic, strong) MKCAttachmentViewController *currentAttachment;
@property (nonatomic, strong) NSArray *attachments;
@property (nonatomic) NSUInteger currentPage;
@property (nonatomic) BOOL isInterfaceHidden;

@end

@implementation MKCAttachmentsViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageViews = [NSMutableArray array];
        _pagingScrollView = [UIScrollView new];
        _pagingScrollView.pagingEnabled = YES;
        _pagingScrollView.backgroundColor = [UIColor blackColor];
        [_pagingScrollView setDelegate:self];
        [self setupGestures];
        
        
        _isInterfaceHidden = NO;
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        _gradientView = [[MKCAttachmentsGradientView alloc] initWithFrame:CGRectMake(0, -20, 100, 25)];
    
        _toolbar = [[UIToolbar alloc] init];
        self.currentPage = 1;
        
        [self setNeedsStatusBarAppearanceUpdate];
    }
    return self;
}

- (void)setupGestures {
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                             initWithTarget:self action:@selector(hideInterface)];
    _doubleTapGestureRecoginzer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTwice)];
    [_pagingScrollView addGestureRecognizer:_tapGestureRecognizer];
    [_pagingScrollView addGestureRecognizer:_doubleTapGestureRecoginzer];
    
    _tapGestureRecognizer.numberOfTapsRequired = 1;
    _doubleTapGestureRecoginzer.numberOfTapsRequired = 2;
    
    [_tapGestureRecognizer requireGestureRecognizerToFail:_doubleTapGestureRecoginzer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUInteger attachmentsCount = [self.attachments count];
    [RACObserve(self, currentPage) subscribeNext:^(NSNumber *newPage) {
        NSUInteger currentIndex = newPage.integerValue - 1;
        NSUInteger attachmentsCount = [self.attachments count];
        self.currentAttachment = self.attachments[currentIndex];
        NSString *title = [NSString stringWithFormat:NSLocalizedString(@"%@ of %lu", nil), newPage, (unsigned long)attachmentsCount];
        [self setTitle:title];
    }];
//
//    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * attachmentsCount,
//                                             self.view.frame.size.height);
    
    [self.view addSubview:self.pagingScrollView];
    
    UIEdgeInsets scrollViewInsets = UIEdgeInsetsMake(0, -10, 0, -10);
    
    [self.pagingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(scrollViewInsets);
    }];
    
    UIView *previousView = nil;
    for (int i = 0; i < attachmentsCount; i++) {
//        MKCPhotoAttachmentViewModel *pvm = self.attachments[i];
//        MKCPhotoAttachmentViewController *pvc = [[MKCPhotoAttachmentViewController alloc] initWithViewModel:pvm];
        
        MKCAttachmentViewController *attachmentVC = self.attachments[i];
        
        [_pageViews addObject:attachmentVC.contentView];
        
        [self addChildViewController:attachmentVC];
        [self.pagingScrollView addSubview:attachmentVC.view];
        
        if (!previousView) {
            [attachmentVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.pagingScrollView.mas_left).with.offset(10);
            }];
        } else {
            [attachmentVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(previousView.mas_right).with.offset(20);
            }];
        }
        
        [attachmentVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view.mas_width);
            make.height.equalTo(self.view.mas_height);
            make.top.equalTo(self.view.mas_top);
        }];
        [attachmentVC didMoveToParentViewController:self];
        previousView = attachmentVC.view;
    }
    
    [self.pagingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(previousView.mas_right).with.offset(10);
    }];
    
    [self setupGradientView];
//    [self setupToolbar];
    
}

- (void)setupGradientView {
    [self.view addSubview:self.gradientView];
    [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(100);
//        make.height.equalTo(@"25");
    }];
}

- (void)setupToolbar {
    [self.view addSubview:self.toolbar];
    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
//        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction:)];
    self.navigationItem.rightBarButtonItem = shareButton;
}

- (void)shareAction:(id)sender {
//    NSLog(@"Share action");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *saveImage = [UIAlertAction actionWithTitle:NSLocalizedString(@"Save to Photo Library", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.currentAttachment saveAttachment];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:saveImage];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)saveImage:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)hideInterface {
    self.isInterfaceHidden = !self.isInterfaceHidden;
    [self.navigationController setNavigationBarHidden:self.isInterfaceHidden animated:YES];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect toolbarRect = self.toolbar.frame;
        CGRect gradientRect = self.gradientView.frame;
        if (self.isInterfaceHidden) {
            self.gradientView.alpha = 0;
            self.toolbar.alpha = 0;
            gradientRect.origin.y -= gradientRect.size.height;
            toolbarRect.origin.y += toolbarRect.size.height;
        } else {
            self.gradientView.alpha = 1;
            self.toolbar.alpha = 1;
            gradientRect.origin.y += gradientRect.size.height;
            toolbarRect.origin.y -= toolbarRect.size.height;
        }
        
        [self.gradientView setFrame:gradientRect];
        [self.toolbar setFrame:toolbarRect];
    }];
}

- (void)tappedTwice {
    [self.currentAttachment viewTappedTwice];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)prefersStatusBarHidden {
    return self.isInterfaceHidden;
}

# pragma mark - MKCAttahcmentsViewInterface

- (void)updateAttachmentsData:(NSArray *)attachments {
    self.attachments = attachments;
}

# pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static NSInteger previousPage = 0;
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if (previousPage != page) {
        // Page has changed, do your thing!
        self.currentPage = page + 1;
        // Finally, update previous page
        previousPage = page;
    }
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
