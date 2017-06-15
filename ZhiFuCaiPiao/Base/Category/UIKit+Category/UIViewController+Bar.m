//
//  UIViewController+Bar.m
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "UIViewController+Bar.h"


@implementation UIViewController (Bar)


- (void)setRightView:(UIView *)view
{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)setLeftView:(UIView *)view
{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = buttonItem;
}

- (void)setNavTitleView:(UIView *)view
{
    [self.navigationItem setTitleView:view];
}


- (UIButton *)createAndSetRightButtonWithTitle:(NSString *)title touchUpInsideAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithTitle:title target:self touchUpInsideAction:action];
    [self setRightView:button];
    return button;
}

- (UIButton *)createAndSetLeftButtonWithTitle:(NSString *)title touchUpInsideAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithTitle:title target:self touchUpInsideAction:action];
    [self setLeftView:button];
    return button;
}


- (UIButton *)createAndSetRightButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage touchUpInsideAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithNormalImage:normalImage highlightedImage:highlightedImage target:self touchUpInsideAction:action];
    [self setRightView:button];
    return button;
}


- (UIButton *)createAndSetLeftButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage touchUpInsideAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithNormalImage:normalImage highlightedImage:highlightedImage target:self touchUpInsideAction:action];
    [self setLeftView:button];
    return button;
}


@end
