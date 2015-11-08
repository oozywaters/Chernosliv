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
#import "MKCVKPost.h"

@interface VKService () <VKSdkDelegate, VKSdkUIDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) NSArray *scope;
@property (nonatomic) BOOL isAuthorized;

@end

@implementation VKService

static NSString *const appId = @"5138913";
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
        _scope = @[VK_PER_WALL, VK_PER_VIDEO, VK_PER_AUDIO];
        VKSdk *sdkInstance = [VKSdk initializeWithAppId:appId];
        [sdkInstance registerDelegate:self];
        [sdkInstance setUiDelegate:self];
        [VKSdk wakeUpSession:_scope completeBlock:^(VKAuthorizationState state, NSError *error) {
            if (state == VKAuthorizationAuthorized) {
                _isAuthorized = YES;
            } else if (state == VKAuthorizationInitialized) {
                _isAuthorized = NO;
            } else if (error) {
                NSLog(@"Authorization error: %@", error);
            }
        }];
//        [VKSdk initializeWithDelegate:self andAppId:appId];
    }
    return self;
}

- (void)authorize {
    [VKSdk authorize:self.scope];
}

- (UIViewController *)rootViewController {
    if (!_rootViewController) {
        _rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    }
    return _rootViewController;
}

# pragma mark - VKSdkDelegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        self.isAuthorized = YES;
        NSLog(@"Authorization finished");
    } else if (result.error) {
        NSLog(@"Authorization finished with error: %@", result.error);
    }
}

- (void)vkSdkUserAuthorizationFailed {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Access denied" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self.rootViewController presentViewController:alertController animated:YES completion:nil];
    NSLog(@"User authorization failed");
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    NSLog(@"Need Captcha Enter");
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    NSLog(@"Token Has Expired");
    [self authorize];
}

- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError {
    NSLog(@"User Denied Access");
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self.rootViewController presentViewController:controller animated:YES completion:nil];
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

- (void)presentAuthDialog {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Требуется авторизация" message:@"Для данного действия необходима авторизация пользователя ВКонтакте" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *authAction = [UIAlertAction actionWithTitle:@"Авторизоваться" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self authorize];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Позже" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel action");
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:authAction];
    [self.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)addLikeToPost:(MKCVKPost *)post {
    
    if (!self.isAuthorized) {
        [self presentAuthDialog];
    } else {
        NSDictionary *parameters = @{@"type": @"post",
                                     @"item_id": post.postId,
                                     VK_API_OWNER_ID: ownerId};
        
        VKRequest *request = [VKRequest requestWithMethod:@"likes.add" andParameters:parameters];
        [request executeWithResultBlock:^(VKResponse *response) {
            NSLog(@"Like post: %@", response);
        } errorBlock:^(NSError *error) {
            NSLog(@"Error while executing likes.add method: %@", error);
        }];
    }
}

@end