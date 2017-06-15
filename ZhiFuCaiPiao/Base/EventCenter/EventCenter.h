//
//  EventCenter.h
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/13.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventCenter : NSObject


+ (instancetype)shared;

/******[ App事件 ]****/
/**
 *  注册程序启动信息，如系统通知，第三方平台库等
 */
- (void)registerApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions;


/**
 *  App失去焦点
 */
- (void)applicationWillResignActive:(UIApplication *)application;


/**
 *  App进入后台
 */
- (void)applicationDidEnterBackground:(UIApplication *)application;


/**
 *  App将回到前台
 */
- (void)applicationWillEnterForeground:(UIApplication *)application;


/**
 *  App获得焦点
 */
- (void)applicationDidBecomeActive:(UIApplication *)application;

/**
 *  App进程将要终止
 */
- (void)applicationWillTerminate:(UIApplication *)application;


/**
 *  App被外部用URL打开
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;


/**
 *  注册远程推送回调唯一标识
 */
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;


/**
 *  本地推送通知
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;


/**
 *  远程推送通知
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;


@end
