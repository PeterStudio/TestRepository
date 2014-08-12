//
//  PTAppDelegate.m
//  Nothing
//
//  Created by dw on 14-8-8.
//  Copyright (c) 2014年 dw. All rights reserved.
//

#import "PTAppDelegate.h"
#import <MAMapKit/MAMapServices.h>
#import <AMapSearchKit/AMapSearchAPI.h>

#import "PTMapViewController.h"
#import "PTWelcomeViewController.h"
#import "PTFriendListViewController.h"
@implementation PTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Map key
    [MAMapServices sharedServices].apiKey =@"918bae79445d2b9650d59f66512992b3";
    // serach key
    //    b7021a3686bc3ec3842686efc0d69927
    //    AMapSearchAPI *search = [[AMapSearchAPI alloc] initWithSearchKey: @"您的key" Delegate:self];
    
    PTMapViewController *mapVC = [[PTMapViewController alloc] init];
    mapVC.title = @"云中央";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mapVC];
    [self.window setRootViewController:nav];
    
//    PTWelcomeViewController *welcomeVC = [[PTWelcomeViewController alloc] init];
//    [self.window setRootViewController:welcomeVC];
    
//    PTFriendListViewController *friendListVC = [[PTFriendListViewController alloc] init];
//    [self.window setRootViewController:friendListVC];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
