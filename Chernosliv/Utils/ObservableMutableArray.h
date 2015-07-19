//
//  ObservableMutableArray.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 16.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ObservableMutableArray;

/// a protocol that is used by observers of the CEObservableMutableArray to determine
/// when the array is mutated
@protocol ObservableMutableArrayDelegate <NSObject>

@optional

/// invoked when an item is added to the array
- (void)array:(ObservableMutableArray *)array didAddItemAtIndex:(NSUInteger) index;

/// invoked when an item is removed from the aray
- (void)array:(ObservableMutableArray *)array didRemoveItemAtIndex:(NSUInteger) index;

/// invoked when an item is replaced
- (void)array:(ObservableMutableArray *)array didReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

/// invoked when an array is added to the array
- (void)array:(ObservableMutableArray *)array didAddObjectsFromArray:(NSArray *)otherArray;

@end

/// a mutable array that informs the delegate of mutations
@interface ObservableMutableArray : NSMutableArray

- (instancetype) initWithArray:(NSArray *)array;

@property (nonatomic, assign) id<ObservableMutableArrayDelegate> delegate;

@end