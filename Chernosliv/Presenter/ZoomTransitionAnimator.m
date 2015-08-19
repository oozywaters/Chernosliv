//
//  ZoomTransitionAnimator.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 12/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "ZoomTransitionAnimator.h"
#import "PostTableViewCell.h"
#import "WallTableViewController.h"
#import "MKCAttachmentsViewController.h"

@implementation ZoomTransitionAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    WallTableViewController *fromVC = (WallTableViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MKCAttachmentsViewController *toVC = (MKCAttachmentsViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Create snapshot of the outgoing view
    PostTableViewCell *currentCell = fromVC.currentCell;
    UIImageView *attachmentsImage = currentCell.postImage;
    
    NSLog(@"attach: %@", attachmentsImage);
    
    UIView *attachmentsImageSnapshot = [attachmentsImage snapshotViewAfterScreenUpdates:NO];
    
    UIView *outgoingSnapshot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    
    UIView *container = [transitionContext containerView];
    
    // Add the incoming view controller
    [container addSubview:toVC.view];
    
    // Build the animation canvas
    UIView *canvas = [[UIView alloc] initWithFrame:container.bounds];
    canvas.backgroundColor = [UIColor blackColor];
    [container addSubview:canvas];
    
    [canvas addSubview:outgoingSnapshot];
    [canvas addSubview:attachmentsImageSnapshot];
    
    // Set the initial frames of the views we're animating
    attachmentsImageSnapshot.frame = [container convertRect:attachmentsImage.bounds fromView:attachmentsImage];
    
    UIView *ongoingImage = (UIView *)toVC.pageViews[0];
    
    [UIView animateWithDuration:0.25 animations:^{
        outgoingSnapshot.alpha = 0.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
//            attachmentsImageSnapshot.center = [[UIScreen mainScreen] cen] ;
            attachmentsImageSnapshot.frame = ongoingImage.frame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            [canvas removeFromSuperview];
        }];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

@end
