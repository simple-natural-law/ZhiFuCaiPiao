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
    
    self.title = self.param[@"title"];
    
    [self showHUD];
    
    [NetworkDataCenter GET:@"http://jisucpkj.market.alicloudapi.com/caipiao/history" parameters:@{@"caipiaoid":@([self.param[@"id"] integerValue]),@"issueno":@"",@"num":@(30)} authorization:@"APPCODE c63ad401f15d451593652310a1905c0c" target:self callBack:@selector(lotteryhistoryCallBack:)];
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
    
    [self pushViewControllerKey:@"LotteryDetailViewController" param:@{@"data":self.dataArray,@"index":@(indexPath.row),@"name":SAVE_STRING(self.title)} animated:YES];
}

#pragma mark-
- (void)lotteryhistoryCallBack:(NSDictionary *)dic
{
    [self hideHUD];
    
//    NSLog(@"--- %@",dic);
    
    if ([dic[@"status"] integerValue] == 0)
    {
        self.dataArray = dic[@"result"][@"list"];
        
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
