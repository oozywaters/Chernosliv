//
//  MKCCommentsDataSource.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 15/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "ObservableMutableArray.h"

@interface MKCCommentsDataSource : NSObject

@property (nonatomic, strong, readonly) ObservableMutableArray *comments;

@end
