//
//  UIViewController+Bar.h
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  扩展导航栏设置
 */
@interface UIViewController (Bar)



/**
 *  设置导航栏上的view
 *
 *  @param view UIView
 */
- (void)setRightView:(UIView *)view;
- (void)setLeftView:(UIView *)view;
- (void)setNavTitleView:(UIView *)view;

/**
 *  创建并设置导航按钮
 *
 *  @param title  标题
 *  @param action 点击事件
 *
 *  @return 创建的UIButton
 */
- (UIButton *)createAndSetRightButtonWithTitle:(NSString *)title touchUpInsideAction:(SEL)action;
- (UIButton *)createAndSetLeftButtonWithTitle:(NSString *)title touchUpInsideAction:(SEL)action;


/**
 *  创建并设置导航按钮
 *
 *  @param normalImage      默认图片
 *  @param highlightedImage 高亮图片
 *  @param action           点击事件
 *
 *  @return 创建的UIButton
 */
- (UIButton *)createAndSetRightButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage touchUpInsideAction:(SEL)action;
- (UIButton *)createAndSetLeftButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage touchUpInsideAction:(SEL)action;



@end
