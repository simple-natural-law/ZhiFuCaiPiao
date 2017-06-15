//
//  UIDevice+extend.h
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (extend)

/**
 *  获取设备版本信息
 *
 *  @return iPhone1,1
 */
+ (NSString*)platform;

/**
 *  获取设备版本名字
 *
 *  @return iPhone 1G
 */
+ (NSString *)platformString;

/**
 *  app版本
 *
 *  @return app版本
 */
+ (NSString *)appVersion;

/**
 *  app build版本
 *
 *  @return app build版本
 */
+ (NSString *)appBuildVersion;

/**
 *  app名称
 *
 *  @return app名称
 */
+ (NSString *)appName;

/**
 *  获取iOS系统版本号
 */
+ (float)iOSVersion;


/**
 *  获取当前手机网络运营商名称
 *  1: 中国移动Mobile, 2: 中国联通 Unicom, 3: 中国电信Telecom, 4: 未知 Unknow
 */
+ (NSInteger)getCarrierName;


@end
