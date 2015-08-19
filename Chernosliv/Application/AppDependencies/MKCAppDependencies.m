//
//  MKCAppDependencies.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCAppDependencies.h"
#import "MKCRootWireframe.h"

@interface MKCAppDependencies ()

@property (nonatomic, strong) MKCRootWireframe *rootWireframe;

@end

@implementation MKCAppDependencies

- (void)installRootViewControllerIntoWindow:(UIWindow *)window {
    [self.rootWireframe showInitialViewControllerInWindow:window];
}

#pragma mark - Private

- (MKCRootWireframe *)rootWireframe
{
    if (!_rootWireframe)
    {
        _rootWireframe = [MKCRootWireframe new];
    }
    return _rootWireframe;
}

@end
