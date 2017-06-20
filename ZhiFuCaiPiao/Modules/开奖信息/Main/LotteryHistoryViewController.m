//
//  LotteryHistoryViewController.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/20.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryHistoryViewController.h"
#import "LotteryHistoryCell.h"


@interface LotteryHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LotteryHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LotteryHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LotteryHistoryCell" forIndexPath:indexPath];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
