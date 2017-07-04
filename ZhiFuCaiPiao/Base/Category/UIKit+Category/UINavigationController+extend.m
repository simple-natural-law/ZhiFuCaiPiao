//
//  UINavigationController+extend.m
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "UINavigationController+extend.h"
#import <objc/runtime.h>


static const char* PushTypeKey = "PushTypeKey";
static const char* WillToBeViewControllerItems = "WillToBeViewControllerItems";
/**
 *  UIViewController push pop 动画扩展
 */
@interface UIViewController (pop) <CAAnimationDelegate>

@property (nonatomic, assign) UINavigationControllerAnimation pushType;

@property (nonatomic, strong) NSArray *willToBeViewControllerItems;

@end


@implementation UIViewController (pop)

- (void)setPushType:(UINavigationControllerAnimation)pushType
{
    objc_setAssociatedObject(self, PushTypeKey, @(pushType), OBJC_ASSOCIATION_ASSIGN);
}

- (UINavigationControllerAnimation)pushType
{
    return [objc_getAssociatedObject(self, PushTypeKey) integerValue];
}

- (void)setWillToBeViewControllerItems:(NSArray *)willToBeViewControllerItems
{
    objc_setAssociatedObject(self, WillToBeViewControllerItems, willToBeViewControllerItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)willToBeViewControllerItems
{
    return (NSArray *)objc_getAssociatedObject(self, WillToBeViewControllerItems);
}

@end



/*
 *  UINavigationController + extend
 */
@implementation UINavigationController (extend)


/**
 *  添加底部push动画
 */
- (void)addBottomPushAnimation
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25 * [[UIScreen  mainScreen] bounds].size.height/[[UIScreen  mainScreen] bounds].size.width;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type     = kCATransitionMoveIn;
    transition.subtype  = kCATransitionFromTop;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
}

/**
 *  添加底部pop动画
 */
- (void)addBottomPopAnimation
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25 * [[UIScreen  mainScreen] bounds].size.height/[[UIScreen  mainScreen] bounds].size.width;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type     = kCATransitionReveal;
    transition.subtype  = kCATransitionFromBottom;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
}


- (void)push:(UIViewController *)viewController animation:(UINavigationControllerAnimation)animation
{
    viewController.pushType = animation;
    
    switch (animation) {
        case UINavigationControllerAnimationNone:
            
            [self pushViewController:viewController animated:NO];
            
            break;
            
        case UINavigationControllerAnimationPush:
            
            [self pushViewController:viewController animated:YES];
            
            break;
            
        case UINavigationControllerAnimationModal:
            
            [self addBottomPushAnimation];
            [self pushViewController:viewController animated:NO];
            
            break;
            
        default:
            break;
    }
}


- (void)pushAnimation:(UINavigationControllerAnimation)animation viewControllers:(UIViewController *)viewControllers, ...
{
    NSMutableArray *viewControllerItems = [NSMutableArray arrayWithObject:viewControllers];
    
    va_list list;
    
    va_start(list, viewControllers);
    
    while (YES) {
        UIViewController *vc = va_arg(list, UIViewController *);
        if (!vc) break;
        [viewControllerItems addObject:vc];
    }
    
    va_end(list);
    
    for (UIViewController *vc in viewControllerItems)
    {
        vc.pushType = animation;
    }
    
    NSMutableArray * items = [NSMutableArray arrayWithArray:self.viewControllers];
    [items addObjectsFromArray:viewControllerItems];
    [items.lastObject setWillToBeViewControllerItems:items];
    self.delegate = self;
    [self push:items.lastObject animation:animation];
}


- (void)popWithAnimation:(UINavigationControllerAnimation)animation
{
    switch (animation) {
        case UINavigationControllerAnimationNone:
            
            [self popViewControllerAnimated:NO];
            
            break;
            
        case UINavigationControllerAnimationPush:
            
            [self popViewControllerAnimated:YES];
            
            break;
            
        case UINavigationControllerAnimationModal:
            
            [self addBottomPopAnimation];
            [self popViewControllerAnimated:NO];
            
            break;
            
        default:
            break;
    }
}


- (void)pop
{
    [self popWithAnimation:self.topViewController.pushType];
}


- (void)popToViewController:(UIViewController *)viewController animation:(UINavigationControllerAnimation)animation
{
    switch (animation) {
        case UINavigationControllerAnimationNone:
            
            [self popToViewController:viewController animated:NO];
            
            break;
            
        case UINavigationControllerAnimationPush:
            
            [self popToViewController:viewController animated:YES];
            
            break;
            
        case UINavigationControllerAnimationModal:
            
            [self addBottomPopAnimation];
            [self popToViewController:viewController animated:NO];
            
            break;
            
        default:
            break;
    }
}


- (void)popToViewController:(UIViewController *)viewController
{
    [self popToViewController:viewController animation:self.topViewController.pushType];
}


#pragma mark - 动画过渡，替换栈内控制器
- (void)replaceAllToViewControllersWithAnimation:(UINavigationControllerAnimation)animation toViewController:(UIViewController *)toViewControllers, ...
{
    NSMutableArray *viewControllerItems = [NSMutableArray arrayWithObject:toViewControllers];
    
    va_list list;
    
    va_start(list, toViewControllers);
    
    while (YES) {
        // 返回可变参数，va_arg第二个参数为可变参数类型，如果有多个可变参数，依次调用可获取各个参数
        UIViewController *vc = va_arg(list, UIViewController *);
        if (!vc) break;
        [viewControllerItems addObject:vc];
    }
    va_end(list);
    
    [self replaceViewControllerWithAnimation:animation formViewController:self.viewControllers.firstObject toViewControllers:viewControllerItems];
}

- (void)replaceViewControllerWithAnimation:(UINavigationControllerAnimation)animation formViewController:(UIViewController *)formViewController toViewController:(UIViewController *)toViewControllers, ...
{
    NSMutableArray *viewControllerItems = [NSMutableArray arrayWithObject:toViewControllers];
    
    va_list list;
    
    va_start(list, toViewControllers);
    
    while (YES) {
        UIViewController *vc = va_arg(list, UIViewController *);
        if (!vc) {
            break;
        }
        
        [viewControllerItems addObject:vc];
    }
    
    va_end(list);
    
    [self replaceViewControllerWithAnimation:animation formViewController:formViewController toViewControllers:viewControllerItems];
}


- (void)replaceViewControllerWithAnimation:(UINavigationControllerAnimation)animation formViewController:(UIViewController *)formViewController toViewControllers:(NSArray *)toViewControllers
{
    NSArray *array = self.viewControllers;
    NSInteger toIndex = [array indexOfObject:formViewController];
    if (toIndex == NSNotFound) {
#ifdef DEBUG_MODE
        NSLog(@"找不到指定控制器 : %@",formViewController);
#endif
        return;
    }
    
    NSMutableArray *willBeItems = [NSMutableArray arrayWithArray:[array subarrayWithRange:NSMakeRange(0, toIndex)]];
    [willBeItems addObjectsFromArray:toViewControllers];
    self.delegate = self;
    [toViewControllers.lastObject setWillToBeViewControllerItems:willBeItems];
    
    [self push:toViewControllers.lastObject animation:animation];
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController.willToBeViewControllerItems.count) {
        navigationController.viewControllers = viewController.willToBeViewControllerItems;
        navigationController.delegate = nil;
        viewController.willToBeViewControllerItems = nil;
    }
}

@end
