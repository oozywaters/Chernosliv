//
//  MKCCommentsInteractor.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 03/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCCommentsInteractorIO.h"

@class MKCCommentsDataManager;

@interface MKCCommentsInteractor : NSObject <MKCCommentsInteractorInput>

@property (nonatomic, weak) id<MKCCommentsInteractorOutput> output;

- (instancetype)initWithDataManager:(MKCCommentsDataManager *)dataManager;

@end
