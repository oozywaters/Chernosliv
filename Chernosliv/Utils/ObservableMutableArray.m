//
//  ObservableMutableArray.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 16.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "ObservableMutableArray.h"

@implementation ObservableMutableArray {
    NSMutableArray *_backingStore;
}

- (instancetype)initWithArray:(NSArray *)array {
    if (self  = [super init]) {
        _backingStore = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

- (id) init {
    if (self  = [super init]) {
        _backingStore = [NSMutableArray new];
    }
    return self;
}

#pragma mark NSArray

-(NSUInteger)count {
    return [_backingStore count];
}

-(id)objectAtIndex:(NSUInteger)index {
    return [_backingStore objectAtIndex:index];
}

#pragma mark NSMutableArray

-(void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [_backingStore insertObject:anObject atIndex:index];
    
    if ([self.delegate respondsToSelector:@selector(array:didAddItemAtIndex:)]) {
        [self.delegate array:self didAddItemAtIndex:index];
    }
}

-(void)removeObjectAtIndex:(NSUInteger)index {
    [_backingStore removeObjectAtIndex:index];
    
    if ([self.delegate respondsToSelector:@selector(array:didRemoveItemAtIndex:)]) {
        [self.delegate array:self didRemoveItemAtIndex:index];
    }
}

-(void)addObject:(id)anObject {
    [_backingStore addObject:anObject];
    
    if ([self.delegate respondsToSelector:@selector(array:didAddItemAtIndex:)]) {
        NSUInteger index = self.count - 1;
        [self.delegate array:self didAddItemAtIndex:index];
    }
}

-(void)removeLastObject {
    [_backingStore removeLastObject];
    
    if ([self.delegate respondsToSelector:@selector(array:didRemoveItemAtIndex:)]) {
        NSUInteger index = self.count - 1;
        [self.delegate array:self didRemoveItemAtIndex:index];
    }
}

-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [_backingStore replaceObjectAtIndex:index withObject:anObject];
    
    if ([self.delegate respondsToSelector:@selector(array:didReplaceObjectAtIndex:withObject:)]) {
        [self.delegate array:self didReplaceObjectAtIndex:index withObject:anObject];
    }
}

- (void)addObjectsFromArray:(NSArray *)otherArray {
    [_backingStore addObjectsFromArray:otherArray];
    
    if ([self.delegate respondsToSelector:@selector(array:didAddObjectsFromArray:)]) {
        [self.delegate array:self didAddObjectsFromArray:otherArray];
    }
}

@end