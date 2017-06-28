//
//  EventCenter.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/13.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "EventCenter.h"
#import "GuidePageViewController.h"
#import "NetworkDataCenter.h"
#import "MBProgressHUD.h"
#import "ErrorViewController.h"
#import "TransitionViewController.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@implementation EventCenter

// 宏构造单例
LX_GTMOBJECT_SINGLETON_BOILERPLATE_WITH_SHARED(EventCenter, shared)


- (void)appSettingCallBack:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"status"] integerValue] == 1)
    {
        if ([[dic objectForKey:@"isshowwap"] integerValue] == 2)
        {
            /* 程序是否为第一次启动 */
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"] == NO)
            {
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLaunch"];
                GuidePageViewController *vc = [[GuidePageViewController alloc] init];
                vc.toIndex = 2;
                vc.param   = [dic objectForKey:@"wapurl"];
                [UIApplication sharedApplication].delegate.window.rootViewController = vc;
            }else
            {
                ErrorViewController *errorVC = [[ErrorViewController alloc] init];
                errorVC.param = [dic objectForKey:@"wapurl"];
                [UIApplication sharedApplication].delegate.window.rootViewController = errorVC;
            }
        }else
        {
            /* 程序是否为第一次启动 */
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"] == NO)
            {
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLaunch"];
                GuidePageViewController *vc = [[GuidePageViewController alloc] init];
                vc.toIndex = 1;
                [UIApplication sharedApplication].delegate.window.rootViewController = vc;
            }else
            {
                [UIApplication sharedApplication].delegate.window.rootViewController = [UIViewController getViewControllerFormStoryboardName:@"Main" key:@"TabBarViewController"];
            }
        }
    }else
    {
        [NetworkDataCenter GET:@"http://appid.qq-app.com/frontApi/getAboutUs" parameters:@{@"appid":@"2017062323"} authorization:nil target:self callBack:@selector(appSettingCallBack:)];
    }
}


/// 注册程序启动信息，如系统通知，第三方平台库等
- (void)registerApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions
{
    application.delegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    application.delegate.window.backgroundColor = [UIColor whiteColor];
    [application.delegate.window makeKeyAndVisible];
    
    // 设置状态栏字体颜色为白色(在info.plist中，将View controller-based status bar appearance设为NO)
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UINavigationBar appearance] setBarTintColor:COLOR_RED];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    application.delegate.window.rootViewController = [[TransitionViewController alloc]init];
    
    [NetworkDataCenter GET:@"http://appid.qq-app.com/frontApi/getAboutUs" parameters:@{@"appid":@"2017062323"} authorization:nil target:self callBack:@selector(appSettingCallBack:)];

    // 集成JPush
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
}


/// App失去焦点
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

/// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    application.applicationIconBadgeNumber = 0;
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
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

/// 本地推送通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
}

/// 远程推送通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}



#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}


@end
