//
//  UIViewController+Nav.m
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "UIViewController+Nav.h"
#import <objc/runtime.h>



static const char* ParamKey    = "ParamKey";
static const char* ParentVCKey = "ParentVCKey";


@implementation UIViewController (Nav)


- (void)setParam:(id)param
{
    objc_setAssociatedObject(self, ParamKey, param, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)param
{
    return (id)objc_getAssociatedObject(self, ParamKey);
}


- (void)setParentVC:(UIViewController *)parentVC
{
    objc_setAssociatedObject(self, ParentVCKey, parentVC, OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController *)parentVC
{
    return (UIViewController *)objc_getAssociatedObject(self, ParentVCKey);
}



+ (UIViewController *)getViewControllerFormStoryboardName:(NSString *)storyboardName key:(NSString *)key
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    
    return [storyboard instantiateViewControllerWithIdentifier:key];
}


- (UIViewController *)getControllerWithKey:(NSString *)key
{
    UIViewController *viewController = nil;
    
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:NSClassFromString(key)])
        {
            viewController = vc;
            break;
        }
    }
    
    return viewController;
}


- (id)pushInstantiateIntiaViewController:(NSString *)storyBoardName param:(id)param animated:(BOOL)animated
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    
    return [self pushViewController:vc param:param animated:animated];
}


- (id)pushInstantiateIntiaViewController:(NSString *)storyBoardName param:(id)param
{
    return [self pushInstantiateIntiaViewController:storyBoardName param:param animated:YES];
}


- (id)pushViewController:(UIViewController *)viewController param:(id)param animated:(BOOL)animated
{
    viewController.param = param;
    viewController.parentVC = (id)self;
    
#if DEBUG_MODE
    NSAssert([viewController isKindOfClass:UIViewController.class], @"实现 <BaseViewControllerInterface> 的类必须是UIViewController或其子类!");
#endif
    
    UINavigationControllerAnimation animation = animated ? UINavigationControllerAnimationPush : UINavigationControllerAnimationNone;
    
    // iOS6会直接Push，这里异步Push控制器，解决参数传递问题
    if ([UIDevice iOSVersion] >= 7.0)
    {
        [self.navigationController push:viewController animation:animation];
    }else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.navigationController push:viewController animation:animation];
        });
    }
    
    return viewController;
}


- (id)pushStoryboardKey:(NSString *)storyboardKey viewControllerKey:(NSString *)viewControllerKey param:(id)param animated:(BOOL)animated
{
    UIViewController *vc = [[self class] getViewControllerFormStoryboardName:storyboardKey key:viewControllerKey];
    return [self pushViewController:vc param:param animated:animated];
}

- (id)pushStoryboardKey:(NSString *)storyboardKey viewControllerKey:(NSString *)viewControllerKey param:(id)param
{
    return [self pushStoryboardKey:storyboardKey viewControllerKey:viewControllerKey param:param animated:YES];
}


- (id)pushViewControllerKey:(NSString *)viewControllerKey param:(id)param animated:(BOOL)animated
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:viewControllerKey];
    
    return [self pushViewController:vc param:param animated:animated];
}

- (id)pushViewControllerKey:(NSString *)viewControllerKey param:(id)param
{
    return [self pushViewControllerKey:viewControllerKey param:param animated:YES];
}

- (id)presentStoryboardKey:(NSString *)storyboardKey viewControllerKey:(NSString *)viewControllerKey param:(id)param
{
    UIViewController *vc = [[self class] getViewControllerFormStoryboardName:storyboardKey key:viewControllerKey];
    vc.parentVC = self;
    vc.param    = param;
    [self.navigationController push:vc animation:UINavigationControllerAnimationModal];
    return vc;
}

- (id)replaceViewControllerKey:(NSString *)viewControllerKey toStoryboardKey:(NSString *)toStoryboardKey toViewControllerKey:(NSString *)toViewControllerKey param:(id)param animation:(UINavigationControllerAnimation)animation
{
    UIViewController * fromViewController = [self getControllerWithKey:viewControllerKey];
    if (fromViewController)
    {
        UIViewController * toViewController = [[self class] getViewControllerFormStoryboardName:toStoryboardKey key:toViewControllerKey];
        [self.navigationController replaceViewControllerWithAnimation:animation formViewController:fromViewController toViewController:toViewController, nil];
        return toViewController;
    }else
    {
#ifdef DEBUG_MODE
        NSLog(@"找不到指定类名的控制器 : %@",viewControllerKey);
#endif
        return nil;
    }
}


- (id)replaceToStoryboardKey:(NSString *)toStoryboardKey toViewControllerKey:(NSString *)toViewControllerKey param:(id)param animation:(UINavigationControllerAnimation)animation
{
    UIViewController *toViewController = [[self class] getViewControllerFormStoryboardName:toStoryboardKey key:toViewControllerKey];
    toViewController.param = param;
    [self.navigationController replaceViewControllerWithAnimation:animation formViewController:self toViewController:toViewController, nil];
    return toViewController;
}

- (id)replaceAllToStorayboardKey:(NSString *)toStoryboardKey toViewControllerKey:(NSString *)toViewControllerKey param:(id)param animation:(UINavigationControllerAnimation)animation
{
    UIViewController *toViewController = [[self class] getViewControllerFormStoryboardName:toStoryboardKey key:toViewControllerKey];
    toViewController.param = param;
    [self.navigationController replaceAllToViewControllersWithAnimation:animation toViewController:toViewController, nil];
    return toViewController;
}


/// 动画过渡，替换underViewController之上的控制器, 通过key索引
- (id)replaceUnderViewControllerKey:(NSString *)underViewControllerKey toStoryboardKey:(NSString *)toStoryboardKey toViewControllerKey:(NSString *)toViewControllerKey param:(id)param animation:(UINavigationControllerAnimation)animation
{
    UIViewController *underViewController = [self getControllerWithKey:underViewControllerKey];
    
    if (underViewController)
    {
        UIViewController *toViewController = [[self class] getViewControllerFormStoryboardName:toStoryboardKey key:toViewControllerKey];
        NSInteger index = [self.navigationController.viewControllers indexOfObject:underViewController];
        if (index < self.navigationController.viewControllers.count - 1) {
            UIViewController *fromViewController = self.navigationController.viewControllers[index + 1];
            [self.navigationController replaceViewControllerWithAnimation:animation formViewController:fromViewController toViewController:toViewController, nil];
        }else
        {
            [self.navigationController push:toViewController animation:animation];
        }
        
        return toViewController;
        
    }else
    {
#ifdef DEBUG_MODE
        NSLog(@"找不到指定类名的控制器 : %@", underViewController);
#endif
        return nil;
    }
}


@end
