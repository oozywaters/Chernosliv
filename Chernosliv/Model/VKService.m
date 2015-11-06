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
#import "MKCWallGetResponse.h"

@interface VKService () <VKSdkDelegate>

@end

@implementation VKService

static NSString *const appId = @"4965407";
static NSString *const ownerId = @"275110350";
//static NSString *const ownerId = @"37807366";

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
        VKSdk *sdkInstance = [VKSdk initializeWithAppId:appId];
        [sdkInstance registerDelegate:self];
//        [VKSdk initializeWithDelegate:self andAppId:appId];
    }
    return self;
}

# pragma mark - VKSdkDelegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    NSLog(@"Authorization finished");
}

- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"User authorization failed");
}

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

- (void)wallGetWithOffset:(NSUInteger)offset count:(NSUInteger)count success:(void (^)(MKCWallGetResponse *))successBlock error:(void (^)(NSError *))errorBlock {
    
    NSDictionary *parameters = @{VK_API_OWNER_ID: ownerId,
                                 VK_API_EXTENDED: @(YES),
                                 VK_API_OFFSET: @(offset),
                                 VK_API_COUNT: @(count)};
    
    VKRequest *wallRequest = [VKRequest requestWithMethod:@"wall.get"
                                            andParameters:parameters];
    [wallRequest setPreferredLang:@"ru"];
    
    [wallRequest executeWithResultBlock:^(VKResponse *response) {
        NSError *parseError;
        
        MKCWallGetResponse *wallResponse = [MTLJSONAdapter modelOfClass:[MKCWallGetResponse class]
                                                     fromJSONDictionary:response.json
                                                                  error:&parseError];
        if (parseError) {
            errorBlock(parseError);
        }
        
        successBlock(wallResponse);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];

}

- (void)getCommentsWithPostId:(NSNumber *)postId
                       offset:(NSUInteger)offset
                        count:(NSUInteger)count
                      success:(void (^)(MKCVKCommentsList *))successBlock
                        error:(void (^)(NSError *))errorBlock {
    
    NSDictionary *parameters = @{VK_API_OWNER_ID: ownerId,
                                 VK_API_POST_ID: postId,
                                 VK_API_OFFSET: @(offset),
                                 VK_API_COUNT: @(count),
                                 VK_API_EXTENDED: @(YES)};
    
    VKRequest *commentsRequest = [VKRequest requestWithMethod:@"wall.getComments"
                                                andParameters:parameters];
    [commentsRequest setPreferredLang:@"ru"];
    
    [commentsRequest executeWithResultBlock:^(VKResponse *response) {
        NSError *parseError;
        
        MKCVKCommentsList *commentsList = [MTLJSONAdapter modelOfClass:[MKCVKCommentsList class] fromJSONDictionary:response.json error:&parseError];
//        NSArray *comments = [MTLJSONAdapter modelsOfClass:[MKCVKComment class] fromJSONArray:response.json error:&parseError];
        
        if (parseError) {
            errorBlock(parseError);
        }
        
        successBlock(commentsList);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

@end