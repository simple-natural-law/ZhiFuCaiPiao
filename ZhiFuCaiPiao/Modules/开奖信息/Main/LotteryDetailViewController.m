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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6+[self.currentLotteryInfo[@"prize"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [UITableViewCell new];
        
    }else if (indexPath.row > 0 && indexPath.row < 5)
    {
        LotteryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LotteryDetailCell" forIndexPath:indexPath];
        
        [cell updateUIWithLotteryInfo:self.currentLotteryInfo row:indexPath.row];
        
        return cell;
    }else
    {
        LotteryPrizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LotteryPrizeCell" forIndexPath:indexPath];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
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
