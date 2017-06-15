//
//  UIView+extend.h
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (extend)


@property (nonatomic, assign) CGFloat filletRadius;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat Y;
@property (nonatomic, assign) CGFloat X;

/**
 *  清除所有subView
 */
-(void)clearAllSubView;

/**
 *  获取所有subView
 *
 *  @return UIView Array
 */
-(NSArray *)allSubViews;

/**
 *  遍历所有subView取消其焦点,收回键盘
 */
-(void)resignResponder;

/**
 *  获取UIView的截图
 *
 *  @return UIImage 图片的width和heigh，会乘以 [UIScreen mainScreen].scale
 */
- (UIImage *)imageSnapshot;

/**
 *  限制 UIView 的宽度，计算出autolayout后的高度
 *
 */
- (CGFloat)viewHeightWithLimitWidth:(CGFloat)limitWidth;


/**
 设置阴影
 */
- (void)setShadow;



@end
