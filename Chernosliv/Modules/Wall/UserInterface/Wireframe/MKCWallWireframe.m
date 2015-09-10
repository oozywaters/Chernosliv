//
//  MKCWallWireframe.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallWireframe.h"
#import "MKCDataStore.h"
#import "MKCWallDataManager.h"
#import "MKCWallPresenter.h"
#import "MKCWallInteractor.h"
#import "MKCWallTableViewController.h"
#import "MKCAttachmentsWireframe.h"

#import "MKCAttachmentsPresentationTransition.h"

#import "MKCCommentsWireframe.h"

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
    
    [navigationController setNavigationBarHidden:YES];
    [navigationController pushViewController:wvc animated:YES];
    
    self.presenter = presenter;
    self.presentedController = navigationController;
    
//    [navigationController setNavigationBarHidden:YES];
}

- (void)presentAttachmentsControllerWithPost:(MKCVKPost *)post {
    MKCAttachmentsWireframe *wireframe = [[MKCAttachmentsWireframe alloc] initWithPost:post];
    [wireframe presentAttachmentsInterfaceFromNavigationController:self.presentedController];
}

- (void)presentCommentsControllerWithPost:(MKCVKPost *)post {
    MKCCommentsWireframe *wireframe = [[MKCCommentsWireframe alloc] initWithPost:post];
    [wireframe presentCommentsInterfaceFromNavigationController:self.presentedController];
//    MKCCommentsWireframe *wireframe = [[MKCCommentsWireframe alloc] initWithPost:post];
//    [wireframe presentCommentsInterfaceFromNavigationController:self.presentedController];
}

@end
