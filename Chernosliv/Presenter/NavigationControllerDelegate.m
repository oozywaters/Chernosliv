//
//  NavigationControllerDelegate.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 12/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "WallTableViewController.h"
#import "MKCAttachmentsViewController.h"
#import "ZoomTransitionAnimator.h"

@implementation NavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
//    NSLog(@"From VC: %@, To VC: %@", fromVC, toVC);
    if ([fromVC isKindOfClass:[WallTableViewController class]] &&
        [toVC isKindOfClass:[MKCAttachmentsViewController class]]) {
        return [ZoomTransitionAnimator new];
    }
    return nil;
}

@end
