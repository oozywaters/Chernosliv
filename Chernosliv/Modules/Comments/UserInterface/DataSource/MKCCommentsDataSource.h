//
//  MKCCommentsDataSource.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 15/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsModuleInterface.h"

@class ANMemoryStorage;
@class MKCCommentsPostDetails;

@interface MKCCommentsDataSource : NSObject

@property (nonatomic, strong) ANMemoryStorage *storage;

- (void)setupStorageWithPostDetails:(MKCCommentsPostDetails *)postDetails
                       eventHandler:(id<MKCCommentsModuleInterface>)eventHandler;

- (void)setupStorageWithItems:(NSArray*)items eventHandler:(id<MKCCommentsModuleInterface>)eventHandler;

@end
