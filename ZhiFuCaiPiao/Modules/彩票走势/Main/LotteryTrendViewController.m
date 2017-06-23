//
//  LotteryTrendViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/15.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryTrendViewController.h"
#import "NetworkDataCenter.h"


@interface LotteryTrendViewController ()

@end

@implementation LotteryTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createAndSetRightButtonWithNormalImage:[UIImage imageNamed:@"select_lottery_type"] highlightedImage:[UIImage imageNamed:@"select_lottery_type_highlighted"] touchUpInsideAction:@selector(selectedLotteryType)];
    
    [self showHUD];
    
    [NetworkDataCenter GET:@"http://api.caipiao.163.com/missNumber_trend.html" parameters:@{@"product":@"caipiao_client",@"mobileType":@"iphone",@"ver":@"4.33",@"channel":@"appstore",@"apiVer":@"1.1",@"apiLevel":@"27",@"deviceId":[UIDevice UDID],@"gameEn":@"ssq"} authorization:nil target:self callBack:@selector(numberTrendCallBack:)];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)numberTrendCallBack:(NSDictionary *)result
{
    [self hideHUD];
    
    NSLog(@"--- %@",result);
}


- (void)selectedLotteryType
{
    
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
