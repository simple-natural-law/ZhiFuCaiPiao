//
//  AppDelegate.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/10.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "AppDelegate.h"
#import "EventCenter.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /// 注册程序启动信息，如系统通知，第三方平台库等
    [[EventCenter shared] registerApplication:application launchOptions:launchOptions];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    // App失去焦点
    [[EventCenter shared] applicationWillResignActive:application];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // App进入后台
    [[EventCenter shared] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    // App将回到前台
    [[EventCenter shared] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // App获得焦点
    [[EventCenter shared] applicationDidBecomeActive:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // 如果支持后台运行，程序将要终止系统会掉用此方法，替代applicationDidEnterBackground:
    // 这个需要要设置UIApplicationExitsOnSuspend的键值。
    [[EventCenter shared] applicationWillTerminate:application];
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    // App被外部URL打开
    return [[EventCenter shared] application:app openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    /// 注册远程推送唯一标示
    [[EventCenter shared] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // 本地推送通知
    [[EventCenter shared] application:application didReceiveLocalNotification:notification];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // 远程推送通知
    [[EventCenter shared] application:application didReceiveRemoteNotification:userInfo];
}


@end
