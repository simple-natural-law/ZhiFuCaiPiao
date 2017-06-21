//
//  LotteryDetailViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/20.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryDetailViewController.h"
#import "LotteryDetailCell.h"


@interface LotteryDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) NSDictionary *currentLotteryInfo;

@end

@implementation LotteryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentLotteryInfo = [self.param[@"data"] objectAtIndex:[self.param[@"index"] integerValue]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        case 1:
            return 1;
            break;
        case 2:
            return [self.currentLotteryInfo[@"prize"] count];
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        LotteryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LotteryDetailCell" forIndexPath:indexPath];
        
        [cell setLotteryInfo:self.currentLotteryInfo name:self.param[@"name"]];
        
        return cell;
        
    }else if (indexPath.section == 1)
    {
        LotteryPrizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LotteryPrizeCell" forIndexPath:indexPath];
        cell.fLabel.text = @"奖项";
        cell.sLabel.text = @"中奖注数";
        cell.tLabel.text = @"每注奖金(元)";
        cell.fLabel.textColor = [UIColor lightGrayColor];
        cell.sLabel.textColor = [UIColor lightGrayColor];
        cell.tLabel.textColor = [UIColor lightGrayColor];
        
        return cell;
    }else
    {
        LotteryPrizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LotteryPrizeCell" forIndexPath:indexPath];
        NSDictionary *dic = self.currentLotteryInfo[@"prize"][indexPath.row];
        cell.fLabel.text = dic[@"prizename"];
        cell.sLabel.text = dic[@"num"];
        cell.tLabel.text = dic[@"singlebonus"];
        cell.fLabel.textColor = [UIColor blackColor];
        cell.sLabel.textColor = [UIColor blackColor];
        cell.tLabel.textColor = COLOR_RED;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return 150.0;
            break;
        case 1:
        case 2:
            return 30.0;
            break;
        default:
            return 0.0;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [UIView new];
    [header setBackgroundColor:COLOR_BACKGROUND];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 1 ? 15.0 : 0.0;
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
