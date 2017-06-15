//
//  NSObject+extend.h
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (extend)

/**
 *  本地对象序列化成json字符串
 *
 *  @return json字符串
 */
- (NSString *)JSONString;

/**
 *  本地对象序列化成json数据流
 *
 *  @return json数据流
 */
- (NSData *)JSONData;

/**
 *  json格式的 NSData 或 NSString 解析成本地对象
 *
 *  @return 本地对象
 */
- (id)objectFromJSON;



@end
