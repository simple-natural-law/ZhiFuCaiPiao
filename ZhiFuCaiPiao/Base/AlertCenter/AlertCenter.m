//
//  AlertCenter.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/20.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "AlertCenter.h"
#import "TabBarViewController.h"


@implementation AlertCenter

+ (void)showWithTitle:(NSString *)title message:(NSString *)message
{
    [self showWithTitle:title message:message cancleButtonTitle:@"确定" cancleBlock:nil];
}


+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancleButtonTitle:(NSString *)buttonTitle
{
    [self showWithTitle:title message:message cancleButtonTitle:buttonTitle cancleBlock:nil];
}


+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancleButtonTitle:(NSString *)buttonTitle cancleBlock:(void (^ __nullable)(UIAlertAction *action))block
{
    if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[UITabBarController class]])
    {
        if ([TabBarViewController shared].selectedViewController.presentedViewController == nil) // 避免重复弹出alert
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:block];
            [alertController addAction:cancelAction];
            [[TabBarViewController shared].selectedViewController presentViewController:alertController animated:YES completion:nil];
        }
    }else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:block];
        [alertController addAction:cancelAction];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}


+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancleButtonTitle:(NSString *)buttonTitle otherButtonTitle:(NSString *)otherButtonTitle cancleBlock:(void (^ __nullable)(UIAlertAction *action))block
{
    [self showWithStyle:UIAlertControllerStyleAlert Title:title message:message cancleButtonTitle:buttonTitle otherButtonTitle:otherButtonTitle destructiveButtonTitle:nil cancleBlock:block];
}

+ (void)showWithStyle:(UIAlertControllerStyle)style Title:(NSString *)title message:(NSString *)message cancleButtonTitle:(NSString *)buttonTitle otherButtonTitle:(NSString *)otherButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle cancleBlock:(void (^ __nullable)(UIAlertAction *action))block
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    if (otherButtonTitle)
    {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:block];
        [alertController addAction:otherAction];
    }
    if (destructiveButtonTitle)
    {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:block];
        [alertController addAction:destructiveAction];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:block];
    [alertController addAction:cancelAction];
    [[TabBarViewController shared].selectedViewController presentViewController:alertController animated:YES completion:nil];
}

+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancleButtonTitle:(NSString *)buttonTitle otherButtonTitle:(NSString *)otherButtonTitle cancleBlock:(void (^ __nullable)(UIAlertAction *action))block
{
    [self showWithStyle:UIAlertControllerStyleActionSheet Title:title message:message cancleButtonTitle:buttonTitle otherButtonTitle:otherButtonTitle destructiveButtonTitle:nil cancleBlock:block];
}


+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancleButtonTitle:(NSString *)buttonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle cancleBlock:(void (^ __nullable)(UIAlertAction *action))block
{
    [self showWithStyle:UIAlertControllerStyleActionSheet Title:title message:message cancleButtonTitle:buttonTitle otherButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle cancleBlock:block];
}


@end
