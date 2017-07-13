//
//  CommonProblemViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/7/13.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "CommonProblemViewController.h"
#import "ProblemDetialViewController.h"

@interface CommonProblemViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CommonProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self pushViewController:[[ProblemDetialViewController alloc] init] param:self.dataArray[indexPath.row] animated:YES];
}



- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[ @{
                            @"title" : @"如何投注双色球",
                            @"html" : @"ssq_howto.html"
                            },
                        @{
                            @"title" : @"如何投注大乐透",
                            @"html" : @"dlt_howto.html"
                            },
                        @{
                            @"title" : @"如何投注广东11选5",
                            @"html" : @"gdy11_howto.html"
                            },
                        @{
                            @"title" : @"如何投注快3",
                            @"html" : @"k3_howto.html"
                            },
                        @{
                            @"title" : @"如何投注3D",
                            @"html" : @"x3d_howto.html"
                            },
                        @{
                            @"title" : @"如何投注时时彩",
                            @"html" : @"ssc_howto.html"
                            },
                        @{
                            @"title" : @"如何投注七星彩",
                            @"html" : @"qxc_howto.html"
                            },
                        @{
                            @"title" : @"如何投注七乐彩",
                            @"html" : @"qlc_howto.html"
                            },
                        @{
                            @"title" : @"如何投注排列5",
                            @"html" : @"pl5_howto.html"
                            },
                        @{
                            @"title" : @"如何投注排列3",
                            @"html" : @"pl3_howto.html"
                            }];
    }
    return _dataArray;
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
