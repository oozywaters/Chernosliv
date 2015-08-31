//
//  MKCAttachmentsWireframe.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCAttachmentsWireframe.h"
#import "MKCAttachmentsPresenter.h"
#import "MKCWallModuleInterface.h"

//#import "AttachmentsViewModel.h"
#import "MKCAttachmentsViewController.h"
#import "MKCAttachmentsPresentationTransition.h"

@interface MKCAttachmentsWireframe () <UINavigationControllerDelegate>

@property (nonatomic, strong) MKCAttachmentsPresenter *presenter;
@property (nonatomic, strong) MKCAttachmentsViewController *viewController;
@property (nonatomic, strong) UINavigationController *presentedController;

@end

@implementation MKCAttachmentsWireframe

- (instancetype)initWithPost:(VKPost *)post {
    self = [super init];
    if (self) {
        _viewController = [MKCAttachmentsViewController new];
        _presenter = [[MKCAttachmentsPresenter alloc] initWithPost:post];
        
        [_presenter configurePresenterWithUserInterface:_viewController];
        _viewController.eventHandler = _presenter;
    }
    return self;
}

- (void)presentAttachmentsInterfaceFromNavigationController:(UINavigationController *)navigationController {
    self.presentedController = navigationController;
    [self.presentedController setDelegate:self];
    [navigationController pushViewController:self.viewController animated:YES];
}

# pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    [navigationController setDelegate:nil];
    return [MKCAttachmentsPresentationTransition new];
}


@end
