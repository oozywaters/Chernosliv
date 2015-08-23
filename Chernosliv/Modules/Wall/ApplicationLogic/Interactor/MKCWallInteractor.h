//
//  MKCWallInteractor.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 20/08/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCWallInteractorIO.h"

@class MKCWallDataManager;

@interface MKCWallInteractor : NSObject <MKCWallInteractorInput>

@property (nonatomic, weak) id<MKCWallInteractorOutput> output;

- (instancetype)initWithDataManager:(MKCWallDataManager *)dataManager;

@end
