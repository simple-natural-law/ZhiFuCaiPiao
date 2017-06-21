//
//  UINavigationController+extend.h
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, UINavigationControllerAnimation) {
    UINavigationControllerAnimationNone  = -1,    // 无动画
    UINavigationControllerAnimationPush  = 0,     // push动画弹出
    UINavigationControllerAnimationModal = 1,     // 模态动画弹出
};

/**
 *  扩展 UINavigationController，实现push时动画选择，实现替换堆栈中的UIViewController
 */
@interface UINavigationController (extend)<UINavigationControllerDelegate>

/**
 *  push 推出UIViewController，并选择动画
 *
 *  @param viewController 要推出的Viewcontroller
 *  @param animation       动画类型
 */
- (void)push:(UIViewController *)viewController animation:(UINavigationControllerAnimation)animation;

/**
 *  push 一组UIViewController(NS_REQUIRES_NIL_TERMINATION－>多参数写法)
 *
 *  @param animation        动画类型
 *  @param viewControllers viewController数组
 */
- (void)pushAnimation:(UINavigationControllerAnimation)animation viewControllers:(UIViewController *)viewControllers,...NS_REQUIRES_NIL_TERMINATION;


/// pop控制器，指定动画类型
- (void)popWithAnimation:(UINavigationControllerAnimation)animation;

/// pop控制器，自动判断动画类型
- (void)pop;

/// pop到指定控制器，指定动画类型
- (void)popToViewController:(UIViewController *)viewController animation:(UINavigationControllerAnimation)animation;

/// pop到指定控制器，自动指定动画类型
- (void)popToViewController:(UIViewController *)viewController;


/// 动画过度，替换栈内所有控制器到viewControllers
- (void)replaceAllToViewControllersWithAnimation:(UINavigationControllerAnimation)animation toViewController:(UIViewController *)toViewControllers,... NS_REQUIRES_NIL_TERMINATION;


/// 动画过渡，替换栈内控制器 formViewController 到 toViewControllers
- (void)replaceViewControllerWithAnimation:(UINavigationControllerAnimation)animation formViewController:(UIViewController *)formViewController toViewController:(UIViewController *)toViewControllers,... NS_REQUIRES_NIL_TERMINATION;



@end
