//
//  UIColor+extend.h
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (extend)

/*
 *将十六进制的颜色值转换为UIColor
 */
+ (UIColor *)colorWithHexString: (NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(float)alpha;

@end
