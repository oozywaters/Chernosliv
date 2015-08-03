//
//  ViewModelServicesImpl.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 28.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewModelServices.h"

@interface ViewModelServicesImpl : NSObject <ViewModelServices>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end
