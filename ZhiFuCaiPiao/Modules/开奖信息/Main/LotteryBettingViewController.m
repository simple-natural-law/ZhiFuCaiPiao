//
//  LotteryBettingViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/7/9.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryBettingViewController.h"

@interface LotteryBettingViewController ()

@end

@implementation LotteryBettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"购彩中心";
    
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.webview.delegate = self;
    [self.view addSubview:self.webview];
    
    [self loadURL:[NSURL URLWithString:self.param] param:nil];
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
