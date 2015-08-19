//
//  MKCRootWireframe.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCRootWireframe.h"
#import "MKCWallWireframe.h"

@implementation MKCRootWireframe

- (void)showInitialViewControllerInWindow:(UIWindow *)window {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    window.backgroundColor = [UIColor clearColor];
    
    MKCWallWireframe *wallWireframe = [MKCWallWireframe new];
    [wallWireframe presentWallInterfaceFromWindow:window];
}

@end
