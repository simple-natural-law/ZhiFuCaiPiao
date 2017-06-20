//
//  LotteryHistoryViewController.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/20.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryHistoryViewController.h"
#import "LotteryHistoryCell.h"
#import "NetworkDataCenter.h"


@interface LotteryHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation LotteryHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showHUD];
    
    [NetworkDataCenter POST:@"http://route.showapi.com/44-2" parameters:@{@"showapi_appid":@"40668",@"showapi_sign":@"11b78d3201e244168488b95fd4c16af4",@"showapi_timestamp":[[NSDate date] toDateString],@"showapi_sign_method":@"md5",@"showapi_res_gzip":@"0",@"code":self.param,@"endTime":@"",@"count":@"10"} target:self callBack:@selector(lotteryhistoryCallBack:)];
}

#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LotteryHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LotteryHistoryCell" forIndexPath:indexPath];
    [cell setLotteryInfo:self.dataArray[indexPath.row]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark-
- (void)lotteryhistoryCallBack:(NSDictionary *)dic
{
    [self hideHUD];
    
    if ([dic[@"showapi_res_code"] integerValue] == 0)
    {
        self.dataArray = dic[@"showapi_res_body"][@"result"];
        
        [self.tableview reloadData];
    }else
    {
        
    }
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
