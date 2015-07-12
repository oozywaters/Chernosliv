//
//  TableViewBindingHelper.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 11.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "TableViewBindingHelper.h"
#import "ReactiveView.h"
#import <ReactiveCocoa/RACEXTScope.h>

@interface TableViewBindingHelper () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) NSArray *data;
@property (nonatomic, strong, readonly) NSString *cellId;
@property (nonatomic, strong, readonly) RACCommand *selection;

@end

@implementation TableViewBindingHelper {
    
//    UITableView *_tableView;
//    NSArray *_data;
//    UITableViewCell *_templateCell;
//    NSString *cellId;
//    RACCommand *_selection;
}

#pragma  mark - initialization

- (instancetype)initWithTableView:(UITableView *)tableView
                     sourceSignal:(RACSignal *)source
                 selectionCommand:(RACCommand *)selection
                   cellIdentifier:(NSString *)cellIdentifier {
    
    if (self = [super init]) {
        _tableView = tableView;
        _data = [NSArray array];
        _selection = selection;
        _cellId = cellIdentifier;
        
        // each time the view model updates the array property, store the latest
        // value and reload the table view
        [source subscribeNext:^(id x) {
            self->_data = x;
            [self->_tableView reloadData];
        }];
        
        // create an instance of the template cell and register with the table view
//        _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
//        [_tableView registerNib:templateCellNib forCellReuseIdentifier:_templateCell.reuseIdentifier];
        
        // use the template cell to set the row height
//        _tableView.rowHeight = _templateCell.bounds.size.height;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return self;
}

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                             sourceSignal:(RACSignal *)source
                         selectionCommand:(RACCommand *)selection
                             cellIdentifier:(NSString *)cellIdentifier {
    
    return [[TableViewBindingHelper alloc] initWithTableView:tableView
                                                  sourceSignal:source
                                              selectionCommand:selection
                                                  cellIdentifier:cellIdentifier];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    id<ReactiveView> cell = [tableView dequeueReusableCellWithIdentifier:_templateCell.reuseIdentifier];
    id<ReactiveView> cell = [tableView dequeueReusableCellWithIdentifier:self.cellId
                                                            forIndexPath:indexPath];
//    if ([cell respondsToSelector:@selector(bindViewModel:)]) {
        [cell bindViewModel:_data[indexPath.row]];
//    }
    return (UITableViewCell *)cell;
}

#pragma mark = UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // execute the command
    [_selection execute:_data[indexPath.row]];
    
    // forward the delegate method
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark = UITableViewDelegate forwarding

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        return self.delegate;
    }
    return [super forwardingTargetForSelector:aSelector];
}

@end