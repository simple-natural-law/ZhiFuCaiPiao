//
//  LotteryTrendViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/15.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryTrendViewController.h"
#import "NetworkDataCenter.h"
#import "LotteryTrendView.h"


@interface LotteryTrendViewController ()

@property (nonatomic, strong) LotteryTrendView *trendView;

@end

@implementation LotteryTrendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.93 blue:0.87 alpha:1.0];
    
    [self createAndSetRightButtonWithNormalImage:[UIImage imageNamed:@"select_lottery_type"] highlightedImage:[UIImage imageNamed:@"select_lottery_type_highlighted"] touchUpInsideAction:@selector(selectedLotteryType)];
    
    self.automaticallyAdjustsScrollViewInsets = NO; // 关闭scrollview自动适应
    
    [self showHUD];
    
    [NetworkDataCenter GET:@"http://api.caipiao.163.com/missNumber_trend.html" parameters:@{@"product":@"caipiao_client",@"mobileType":@"iphone",@"ver":@"4.33",@"channel":@"appstore",@"apiVer":@"1.1",@"apiLevel":@"27",@"deviceId":[UIDevice UDID],@"gameEn":@"ssq"} authorization:nil target:self callBack:@selector(ssqNumberTrendCallBack:)];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)ssqNumberTrendCallBack:(NSDictionary *)result
{
    [self hideHUD];
    
    NSArray *resultArray = [result[@"data"] subarrayWithRange:NSMakeRange(0, 50)];
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:30];
    
    for (NSDictionary *dic in resultArray)
    {
        @autoreleasepool {
            NSMutableDictionary *dataDic = [dic mutableCopy];
            NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"general"] subarrayWithRange:NSMakeRange(0, 33)];
            [dataDic setObject:missNumArr forKey:@"missNumber"];
            [dataArray addObject:dataDic];
        }
    }
    self.trendView = [[LotteryTrendView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, kScreenHeight-213) type:LotteryTrendTypeSsqRed dataArray:dataArray];
    [self.view addSubview:self.trendView];
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
