//
//  UIViewController+HUD.m
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"


@implementation UIViewController (HUD)

- (void)showHUD
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.animationType = MBProgressHUDModeIndeterminate;
    hud.minShowTime   = 0.27;
    self.view.userInteractionEnabled = NO;
}

- (void)showHUDWithStatus:(NSString *)status
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.animationType = MBProgressHUDModeIndeterminate;
    hud.minShowTime   = 0.27;
    hud.label.text = status;
    self.view.userInteractionEnabled = NO;
}


- (void)hideHUD
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.view.userInteractionEnabled = YES;
}

- (void)showHint:(NSString *)hint
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.frame = [UIScreen mainScreen].bounds;
    hud.mode  = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}


@end
