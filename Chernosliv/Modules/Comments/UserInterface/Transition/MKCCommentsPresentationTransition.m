//
//  MKCCommentsPresentationTransition.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 31/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsPresentationTransition.h"
#import "MKCWallVC.h"
#import "MKCCommentsViewController.h"

@implementation MKCCommentsPresentationTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    MKCWallVC *fromVC = (MKCWallVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MKCCommentsViewController *toVC = (MKCCommentsViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *outgoingSnapshot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    
    UIView *container = [transitionContext containerView];
    
    // Add the incoming view controller
    [container addSubview:toVC.view];
    
    UIView *canvas = [[UIView alloc] initWithFrame:container.bounds];
    canvas.backgroundColor = [UIColor blackColor];
    [container addSubview:canvas];

    [canvas addSubview:outgoingSnapshot];
    
    [UIView animateWithDuration:0.5 animations:^{
        outgoingSnapshot.alpha = 0.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [canvas removeFromSuperview];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return .5;
}

@end
