//
//  MKCWallWireframe.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallWireframe.h"
#import "MKCWallDataManager.h"
#import "MKCWallPresenter.h"
#import "MKCWallInteractor.h"
#import "MKCWallTableViewController.h"
#import "MKCAttachmentsWireframe.h"

#import "MKCAttachmentsPresentationTransition.h"

@interface MKCWallWireframe () <UINavigationControllerDelegate>

@property (nonatomic, strong) UINavigationController *presentedController;
@property (nonatomic, strong) MKCWallPresenter *presenter;

@end

@implementation MKCWallWireframe

- (void)presentWallInterfaceFromWindow:(UIWindow *)window {
    UINavigationController *nc = [UINavigationController new];
    window.rootViewController = nc;
    [self presentWallViewControllerFromNavigationController:nc];
}

- (void)presentWallViewControllerFromNavigationController:(UINavigationController *)navigationController {
    MKCWallDataManager *dataManager = [MKCWallDataManager new];
    MKCWallInteractor *interactor = [[MKCWallInteractor new] initWithDataManager:dataManager];
    MKCWallTableViewController *wvc = [MKCWallTableViewController new];
    MKCWallPresenter *presenter = [MKCWallPresenter new];
    
    interactor.output = presenter;
    presenter.interactor = interactor;
    
    wvc.eventHandler = presenter;
    
    presenter.wireframe = self;
    [presenter configurePresenterWithUserInterface:wvc];
    
    [navigationController pushViewController:wvc animated:YES];
    
    self.presenter = presenter;
    self.presentedController = navigationController;
}

- (void)presentAttachmentsControllerWithPost:(VKPost *)post {
    [self.presentedController setDelegate:self];
    
    MKCAttachmentsWireframe *wireframe = [[MKCAttachmentsWireframe alloc] initWithPost:post];
    [wireframe presentAttachmentsInterfaceFromNavigationController:self.presentedController];
}

# pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    return [MKCAttachmentsPresentationTransition new];
}


@end
