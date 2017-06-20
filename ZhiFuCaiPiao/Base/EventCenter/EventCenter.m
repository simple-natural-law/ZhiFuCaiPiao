//
//  EventCenter.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/13.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "EventCenter.h"

@implementation EventCenter

// 宏构造单例
LX_GTMOBJECT_SINGLETON_BOILERPLATE_WITH_SHARED(EventCenter, shared)

/// 注册程序启动信息，如系统通知，第三方平台库等
- (void)registerApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions
{
    // 设置状态栏字体颜色为白色(在info.plist中，将View controller-based status bar appearance设为NO)
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UINavigationBar appearance] setBarTintColor:COLOR_BLUE];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


/// App失去焦点
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

/// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

/// 进程中止
- (void)applicationWillTerminate:(UIApplication *)application
{
    
}


/// App将回到前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}


/// App获得焦点
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

/// App被外部用URL打开
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

#pragma mark -推送
/// 注册远程推送回调唯一标识
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
}

/// 本地推送通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
}

/// 远程推送通知

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

@end
