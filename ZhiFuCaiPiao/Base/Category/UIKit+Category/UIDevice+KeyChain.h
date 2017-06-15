//
//  UIDevice+KeyChain.h
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (KeyChain)

/**
 *  从KeyChain中读取设备的UDID，如果没有，先创建保存，然后返回
 *
 *  @return UDID (GUID)
 */
+ (NSString *)UDID;


/**
 *  保存数据到KeyChain
 *
 *  @param key      数据标识符key
 *  @param object   需要保存的对象
 */
+ (void)saveKey:(NSString *)key object:(id)object;

/**
 *  删除KeyChain中的数据
 *
 *  @param key      数据标识符key
 */
+ (void)deleteObjectWithKey:(NSString *)key;


/**
 *  获取KeyChain中的数据
 *
 *  @param key      数据标识符key
 *  @return         object
 */
+ (id)getObjectWithKey:(NSString *)key;



@end
