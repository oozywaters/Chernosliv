//
//  MKCAttachmentsPresentationTransition.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 20/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCAttachmentsPresentationTransition.h"
#import "MKCWallVC.h"
#import "MKCAttachmentsViewController.h"
#import "MKCAttachmentsGradientView.h"

@implementation MKCAttachmentsPresentationTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    MKCWallVC *fromVC = (MKCWallVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MKCAttachmentsViewController *toVC = (MKCAttachmentsViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Create snapshot of the outgoing view
//    PostTableViewCell *currentCell = fromVC.currentCell;
    UIView *attachmentsImage = fromVC.tappedView;
   
    UIView *attachmentsImageSnapshot = [attachmentsImage snapshotViewAfterScreenUpdates:NO];
    
    UIView *outgoingSnapshot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    
    UIView *container = [transitionContext containerView];
    MKCAttachmentsGradientView *gradientView = [[MKCAttachmentsGradientView alloc] initWithFrame:CGRectMake(0, 0, outgoingSnapshot.frame.size.width, 100)];
    gradientView.alpha = 0;
    
    // Add the incoming view controller
    [container addSubview:toVC.view];
    
    // Build the animation canvas
    UIView *canvas = [[UIView alloc] initWithFrame:container.bounds];
    canvas.backgroundColor = [UIColor blackColor];
    [container addSubview:canvas];
    
    [canvas addSubview:outgoingSnapshot];
    [canvas addSubview:attachmentsImageSnapshot];
    [canvas addSubview:gradientView];
    
    // Set the initial frames of the views we're animating
    attachmentsImageSnapshot.frame = [container convertRect:attachmentsImage.bounds fromView:attachmentsImage];
    
    UIView *ongoingImage = (UIView *)toVC.pageViews[0];
    
    [UIView animateWithDuration:0.75 animations:^{
        gradientView.alpha = 1;
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        outgoingSnapshot.alpha = 0.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
            //            attachmentsImageSnapshot.center = [[UIScreen mainScreen] cen] ;
            attachmentsImageSnapshot.frame = ongoingImage.frame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            [canvas removeFromSuperview];
        }];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.75;
}

@end
