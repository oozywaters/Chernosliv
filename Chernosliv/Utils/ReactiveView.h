//
//  ReactiveView.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 11.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@import Foundation;

/// A protocol which is adopted by views which are backed by view models.
@protocol ReactiveView <NSObject>

/// Binds the given view model to the view
- (void)bindViewModel:(id)viewModel;

@end