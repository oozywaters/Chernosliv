//
//  ViewModelServicesImpl.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 28.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "ViewModelServicesImpl.h"
#import "AttachmentsViewModel.h"
#import "AttachmentsViewController.h"

@interface ViewModelServicesImpl ()

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation ViewModelServicesImpl

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        _navigationController = navigationController;
    }
    return self;
}

- (void)pushViewModel:(id)viewModel {
    id viewController;
    
    if ([viewModel isKindOfClass:[AttachmentsViewModel class]]) {
        viewController = [[AttachmentsViewController alloc] initWithViewModel:viewModel];
    } else {
        NSLog(@"An unknown model was pushed");
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
