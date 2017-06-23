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

@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) NSDictionary *currentLotteryInfo;
@property (assign, nonatomic) NSInteger currentIndex;

@property (assign, nonatomic) BOOL hasPrizeInfo;

@end

@implementation LotteryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.lastButton setBackgroundImage:[UIImage imageWithColor:COLOR_RED] forState:UIControlStateNormal];
    [self.lastButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:226/255.0 green:17/255.0 blue:0 alpha:0.7f]] forState:UIControlStateHighlighted];
    [self.lastButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
    [self.nextButton setBackgroundImage:[UIImage imageWithColor:COLOR_RED] forState:UIControlStateNormal];
    [self.nextButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:226/255.0 green:17/255.0 blue:0 alpha:0.7f]] forState:UIControlStateHighlighted];
    [self.nextButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
    
    self.currentIndex = [self.param[@"index"] integerValue];
    self.currentLotteryInfo = [self.param[@"data"] objectAtIndex:self.currentIndex];
    
    if (self.currentIndex == 0)
    {
        self.lastButton.enabled = NO;
    }else if (self.currentIndex == 19)
    {
        self.nextButton.enabled = NO;
    }
    
    if ([self.currentLotteryInfo[@"prize"] isKindOfClass:[NSArray class]])
    {
        self.hasPrizeInfo = YES;
    }else
    {
        self.hasPrizeInfo = NO;
    }
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
            return self.hasPrizeInfo ? [self.currentLotteryInfo[@"prize"] count] : 0;
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
        if (self.hasPrizeInfo)
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
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
            cell.textLabel.text = @"暂无中奖数据,敬请谅解";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor     = COLOR_RED;
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.backgroundColor = [UIColor clearColor];
            
            return cell;
        }
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

#pragma mark- button action
- (IBAction)lastIssueno:(id)sender
{
    [self showHUD];
    self.currentIndex -= 1;
    self.currentLotteryInfo = [self.param[@"data"] objectAtIndex:self.currentIndex];
    [self.tableview beginUpdates];
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableview endUpdates];
    [self hideHUD];
    if (self.currentIndex == 0)
    {
        self.lastButton.enabled = NO;
    }else if (self.currentIndex == 19)
    {
        self.nextButton.enabled = NO;
    }else if (self.currentIndex == 1)
    {
        self.lastButton.enabled = YES;
    }else if (self.currentIndex == 18)
    {
        self.nextButton.enabled = YES;
    }
}

- (IBAction)nextIssueno:(id)sender
{
    [self showHUD];
    self.currentIndex += 1;
    self.currentLotteryInfo = [self.param[@"data"] objectAtIndex:self.currentIndex];
    [self.tableview beginUpdates];
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableview endUpdates];
    [self hideHUD];
    
    if (self.currentIndex == 0)
    {
        self.lastButton.enabled = NO;
    }else if (self.currentIndex == 19)
    {
        self.nextButton.enabled = NO;
    }else if (self.currentIndex == 1)
    {
        self.lastButton.enabled = YES;
    }else if (self.currentIndex == 18)
    {
        self.nextButton.enabled = YES;
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
