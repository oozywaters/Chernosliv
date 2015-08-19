//
//  MKCWallWireframe.m
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallWireframe.h"
#import "WallViewModel.h"
#import "WallTableViewController.h"
#import "ViewModelServicesImpl.h"

@interface MKCWallWireframe ()

@property (nonatomic, strong) UINavigationController *presentedController;

@end

@implementation MKCWallWireframe

- (void)presentWallInterfaceFromWindow:(UIWindow *)window {
    UINavigationController *nc = [UINavigationController new];
    window.rootViewController = nc;
    [self presentWallViewControllerFromNavigationController:nc];
}

- (void)presentWallViewControllerFromNavigationController:(UINavigationController *)navigationController {
    ViewModelServicesImpl *vmServices = [[ViewModelServicesImpl alloc] initWithNavigationController:navigationController];
    WallViewModel *wvm = [[WallViewModel alloc] initWithServices:vmServices];
    WallTableViewController *wvc = [[WallTableViewController alloc] initWithViewModel:wvm];
    
    [navigationController pushViewController:wvc animated:YES];
    
    self.presentedController = navigationController;
}

@end
