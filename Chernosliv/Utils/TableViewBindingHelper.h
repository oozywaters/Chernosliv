//
//  TableViewBindingHelper.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 11.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@import Foundation;
#import <ReactiveCocoa/ReactiveCocoa.h>

/// A helper class for binding view models with NSArray properties to a UITableView.
@interface TableViewBindingHelper : NSObject

// forwards the UITableViewDelegate methods
@property (weak, nonatomic) id<UITableViewDelegate> delegate;

- (instancetype) initWithTableView:(UITableView *)tableView
                      sourceSignal:(RACSignal *)source
                  selectionCommand:(RACCommand *)selection
                      cellIdentifier:(NSString *)cellIdentifier;

+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)selection
                            cellIdentifier:(NSString *)cellIdentifier;

@end