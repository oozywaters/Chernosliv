//
//  MKCCommentsWireframe.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsWireframe.h"
#import "MKCCommentsPresenter.h"
#import "MKCCommentsViewController.h"
#import "MKCCommentsPresentationTransition.h"

@interface MKCCommentsWireframe () <UINavigationControllerDelegate>

@property (nonatomic, strong) MKCCommentsViewController *viewController;
@property (nonatomic, strong) MKCCommentsPresenter *presenter;
@property (nonatomic, strong) UINavigationController *presentedController;

@end

@implementation MKCCommentsWireframe

- (instancetype)initWithPost:(VKPost *)post {
    self = [super init];
    if (self) {
        _viewController = [MKCCommentsViewController new];
        _presenter = [[MKCCommentsPresenter alloc] initWithPost:post];
        
        [_presenter configurePresenterWithUserInterface:_viewController];
        _viewController.eventHandler = _presenter;
    }
    return self;
}

- (void)presentCommentsInterfaceFromNavigationController:(UINavigationController *)navigationController {
    self.presentedController = navigationController;
    
    [navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navigationController.navigationBar.shadowImage = [UIImage new];
    navigationController.navigationBar.translucent = YES;
    navigationController.view.backgroundColor = [UIColor clearColor];
    navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    [self.presentedController setDelegate:self];
    [navigationController pushViewController:self.viewController animated:YES];
}

# pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    [navigationController setDelegate:nil];
    return [MKCCommentsPresentationTransition new];
}

@end
