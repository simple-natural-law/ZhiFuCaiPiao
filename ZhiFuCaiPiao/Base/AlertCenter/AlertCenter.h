//
//  AlertCenter.h
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/20.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertCenter : NSObject

/// show alert and cancelButtonTitle is @"确定"(只有一个按钮的alert)
+ (void)showWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message;
+ (void)showWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message cancleButtonTitle:(NSString *_Nullable)buttonTitle;
+ (void)showWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message cancleButtonTitle:(NSString *_Nullable)buttonTitle cancleBlock:(void (^ __nullable)(UIAlertAction * _Nullable action))block;

// 2个按钮的alert(根据按钮的UIAlertActionStyle判断点击的是取消按钮还是其他按钮)
+ (void)showWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message cancleButtonTitle:(NSString *_Nullable)buttonTitle otherButtonTitle:(NSString *_Nullable)otherButtonTitle cancleBlock:(void (^ __nullable)(UIAlertAction * _Nullable action))block;

/// actionSheet
+ (void)showActionSheetWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message cancleButtonTitle:(NSString *_Nullable)buttonTitle otherButtonTitle:(NSString *_Nullable)otherButtonTitle cancleBlock:(void (^ __nullable)(UIAlertAction * _Nullable action))block;

+ (void)showActionSheetWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message cancleButtonTitle:(NSString *_Nullable)buttonTitle destructiveButtonTitle:(NSString *_Nullable)destructiveButtonTitle cancleBlock:(void (^ __nullable)(UIAlertAction * _Nullable action))block;

@end
