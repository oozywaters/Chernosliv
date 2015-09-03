//
//  VKWall.h
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Mantle.h>

@interface VKWall : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray *posts; //of VKPost
@property (nonatomic) NSUInteger overallPostsCount;
//@property (nonatomic) NSUInteger loadedPostsCount;

- (BOOL)updateWithJSON:(NSDictionary*)json error:(NSError**)error;

- (NSUInteger)postsCount;

@end
