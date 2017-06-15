//
//  UIButton+extend.h
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (extend)

/**
 *  标题
 */
@property (nonatomic) NSString *title;


/**
 *  创建UIButton,根据标题大小自动设置frame.size
 *
 *  @param title  标题
 *  @param target 回调对象
 *  @param action 点击事件
 *
 *  @return UIButton
 */
+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target touchUpInsideAction:(SEL)action;

/**
 *  创建UIButton,根据normalImage大小自动设置frame.size
 *
 *  @param normalImage      默认图片
 *  @param highlightedImage 高亮图片
 *  @param target           回调对象
 *  @param action           点击事件
 *
 *  @return UIButton
 */
+ (UIButton *)buttonWithNormalImage:(UIImage *)normalImage
                   highlightedImage:(UIImage *)highlightedImage
                             target:(id)target
                touchUpInsideAction:(SEL)action;


@end
