//
//  MKCVKCommentsList.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 04/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MKCVKCommentsList : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSDictionary *profiles;

@end
