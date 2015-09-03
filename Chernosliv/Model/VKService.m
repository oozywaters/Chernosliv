//
//  VKService.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 12.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Mantle/Mantle.h>
#import "VKService.h"
#import <VKSdk.h>
#import "VKWall.h"
#import "MKCVKCommentsList.h"

@interface VKService () <VKSdkDelegate>

@end

@implementation VKService

static NSString *const appId = @"4965407";
static NSString *const ownerId = @"275110350";

+ (VKService *)sharedService {
    static VKService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[VKService alloc] init];
    });
    return service;
}

- (instancetype)init {
    if (self = [super init]) {
        [VKSdk initializeWithDelegate:self andAppId:appId];
        _wall = [VKWall new];
    }
    return self;
}

# pragma mark - VKSdkDelegate

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    NSLog(@"Need Captcha Enter");
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    NSLog(@"Token Has Expired");
}

- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError {
    NSLog(@"User Denied Access");
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    NSLog(@"Should Present View Controller");
}

- (void)vkSdkReceivedNewToken:(VKAccessToken *)newToken {
    NSLog(@"Received New Token");
}

# pragma mark - API

- (void)getPostsWithOffset:(NSUInteger)offset
                         count:(NSUInteger)count
                     onSuccess:(void (^)(NSArray *posts))successBlock
                       onError:(void (^)(NSError *error))errorBlock {
    
    NSDictionary *parameters = @{VK_API_OWNER_ID: ownerId,
                                 VK_API_OFFSET: @(offset),
                                 VK_API_COUNT: @(count)};
    
    VKRequest *wallRequest = [VKRequest requestWithMethod:@"wall.get"
                                            andParameters:parameters
                                            andHttpMethod:@"GET"];
    
    [wallRequest executeWithResultBlock:^(VKResponse *response) {
        NSError *parseError;
        
        self.wall = [MTLJSONAdapter modelOfClass:[VKWall class]
                              fromJSONDictionary:response.json
                                           error:&parseError];
        if (parseError) {
            errorBlock(parseError);
        }
        
        successBlock(self.wall.posts);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getCommentsWithPostId:(NSString *)postId
                       success:(void (^)(NSArray *comments))successBlock
                         error:(void(^)(NSError *error))errorBlock {
    
    NSDictionary *parameters = @{VK_API_OWNER_ID: ownerId,
                                 VK_API_POST_ID: postId,
                                 VK_API_EXTENDED: @"1"};
    
    VKRequest *commentsRequest = [VKRequest requestWithMethod:@"wall.getComments"
                                                andParameters:parameters
                                                andHttpMethod:@"GET"];
    [commentsRequest executeWithResultBlock:^(VKResponse *response) {
        NSError *parseError;
        
        MKCVKCommentsList *commentsList = [MTLJSONAdapter modelOfClass:[MKCVKCommentsList class] fromJSONDictionary:response.json error:&parseError];
        
        NSLog(@"Comments: %@", commentsList.profiles);
        
     
//        NSArray *comments = [MTLJSONAdapter modelsOfClass:[MKCVKComment class] fromJSONArray:response.json error:&parseError];
        
        if (parseError) {
            errorBlock(parseError);
        }
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

@end