//
//  MKCVKProfile.h
//  Chernosliv
//
//  Created by Vyacheslav Zavertanny on 04/09/15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MKCVKProfile : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
//@property (nonatomic, strong) NSURL *photo;

@end
