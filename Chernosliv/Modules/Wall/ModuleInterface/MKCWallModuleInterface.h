//
//  MKCWallModuleInterface.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 19/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

@protocol MKCWallModuleDelegate;

@protocol MKCWallModuleInterface <NSObject>

@property (nonatomic, strong) id<MKCWallModuleDelegate> wallModuleDelegate;

- (void)loadNextPage;

@end
