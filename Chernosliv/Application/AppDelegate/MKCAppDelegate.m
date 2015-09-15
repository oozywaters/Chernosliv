//
//  AppDelegate.m
//  Chernosliv
//
//  Created by Vacheslav Zavertanny on 11.07.15.
//  Copyright (c) 2015 Vyacheslav Zavertanny. All rights reserved.
//

#import "MKCAppDelegate.h"
#import "MKCWallTableViewController.h"
#import <VKSdk.h>

#import "MKCAppDependencies.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface MKCAppDelegate ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) MKCAppDependencies *appDependencies;

@end

@implementation MKCAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.appDependencies installRootViewControllerIntoWindow:self.window];
    [self.window makeKeyAndVisible];
//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
//    {
//        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
//        view.backgroundColor=[UIColor whiteColor];
//        [self.window.rootViewController.view addSubview:view];
//    }
    
//    // Override point for customization after application launch.
//    self.navigationController = [UINavigationController new];
//    self.navigationControllerDelegate = [NavigationControllerDelegate new];
//    self.navigationController.delegate = self.navigationControllerDelegate;
//    
//    // create and navigate to a view controller
//    UIViewController *viewController = [self createInitialViewController];
//    [self.navigationController pushViewController:viewController animated:NO];
//    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = self.navigationController;
//    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    return YES;
}

#pragma mark - Private

- (MKCAppDependencies *)appDependencies
{
    if (!_appDependencies)
    {
        _appDependencies = [MKCAppDependencies new];
    }
    return _appDependencies;
}

@end
