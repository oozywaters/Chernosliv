//
//  MKCCommentsWireframe.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsWireframe.h"
#import "MKCCommentsDataManager.h"

#import "MKCCommentsPresenter.h"
#import "MKCCommentsViewController.h"
#import "MKCCommentsInteractor.h"
#import "MKCCommentsPresentationTransition.h"

@interface MKCCommentsWireframe () <UINavigationControllerDelegate>

@property (nonatomic, strong) MKCCommentsViewController *viewController;
@property (nonatomic, strong) UINavigationController *presentedController;

//@property (nonatomic, strong) MKCCommentsPresenter *presenter;
//@property (nonatomic, strong) MKCCommentsInteractor *interactor;

@end

@implementation MKCCommentsWireframe

- (instancetype)initWithPost:(VKPost *)post {
    self = [super init];
    if (self) {
        MKCCommentsDataManager *dataManager = [MKCCommentsDataManager new];
        MKCCommentsInteractor *interactor = [[MKCCommentsInteractor alloc] initWithDataManager:dataManager];
        MKCCommentsPresenter *presenter = [[MKCCommentsPresenter alloc] initWithPost:post];
        
        interactor.output = presenter;
        presenter.interactor = interactor;
        
        _viewController = [MKCCommentsViewController new];
        _viewController.eventHandler = presenter;
        
        [presenter configurePresenterWithUserInterface:_viewController];
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
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.presentedController setDelegate:nil];
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
