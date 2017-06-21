//
//  LotteryTrendViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/15.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryTrendViewController.h"

@interface LotteryTrendViewController ()

@end

@implementation LotteryTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGRect frame = self.navigationController.tabBarController.view.frame;
    if (frame.size.height == kScreenHeight - 64)
    {
        frame.size.height -= 49;
        self.navigationController.tabBarController.view.frame = frame;
    }
    self.navigationController.tabBarController.tabBar.hidden = NO;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    CGRect frame = self.navigationController.tabBarController.view.frame;
    frame.size.height += 49;
    self.navigationController.tabBarController.view.frame = frame;
    self.navigationController.tabBarController.tabBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
