//
//  UIViewController+HUD.h
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

// 显示活动指示器
- (void)showHUD;
- (void)showHUDWithStatus:(NSString *)status;

// 隐藏活动指示器
- (void)hideHUD;

//  提示文字信息
- (void)showHint:(NSString *)hint;


@end
