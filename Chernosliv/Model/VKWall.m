//
//  VKWall.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 14.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "VKWall.h"
#import "VKPost.h"
#import <VKSdk.h>

@interface VKWall ()


@end


@implementation VKWall

- (instancetype)init {
    if (self = [super init]) {
        _overallPostsCount = 0;
    }
    return self;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"posts": @"items",
             @"overallPostsCount": @"count"};
}

+ (NSValueTransformer *)postsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[VKPost class]];
}

- (NSUInteger)postsCount {
    return self.postsCount;
}

- (BOOL)updateWithJSON:(NSDictionary *)json error:(NSError *__autoreleasing *)error {
    // create a temporary object then merge it by its JSON keys
    VKWall *model = [MTLJSONAdapter modelOfClass:[self class]
                                     fromJSONDictionary:json
                                                  error:error];
    
    if (*error != nil) {
        return NO;
    }
    
    NSArray *keysOfJSONProperties = [[[self class] JSONKeyPathsByPropertyKey] allKeys];
    
    for (id key in keysOfJSONProperties) {
        [self mergeValueForKey:key fromModel: model];
    }
    
    return YES;
}

//- (void)requestPosts:(void (^)(NSArray *posts))successBlock
//             onError:(void (^)(NSError *error))errorBlock {
//    NSDictionary *parameters = @{VK_API_OWNER_ID: self.ownerId,
//                                 VK_API_OFFSET: @([self loadedPostsCount]),
//                                 VK_API_COUNT: @(self.pageSize)};
//    
//    VKRequest *wallRequest = [VKRequest requestWithMethod:@"wall.get" andParameters:parameters andHttpMethod:@"GET"];
//    
//    
////    [wallRequest executeWithResultBlock:^(VKResponse *response) {
////        NSError *parseError;
//    
//        //        BOOL update = [self.wall updateWithJSON:response.json error:&parseError];
//        //
//        //        if (!update) {
//        //            errorBlock(parseError);
//        //        }
//        
////        VKWall *wall = [MTLJSONAdapter modelOfClass:[VKWall class] fromJSONDictionary:response.json error:&parseError];
////        if (parseError) {
////            errorBlock(parseError);
////        }
////        
////        [self.wall.posts addObjectsFromArray:wall.posts];
////        
////        NSLog(@"%lu", [self.wall postsCount]);
////        successBlock(self.wall.posts);
//    } errorBlock:^(NSError *error) {
//        errorBlock(error);
//    }];
//
//}

@end
