//
//  ReactiveView.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 11.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

/// A protocol which is adopted by views which are backed by view models.
@protocol ReactiveView <NSObject>

@property (nonatomic, weak) id delegate;

/// Binds the given view model to the view
- (void)bindViewModel:(id)viewModel;

@end