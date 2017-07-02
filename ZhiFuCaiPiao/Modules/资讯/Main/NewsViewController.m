//
//  NewsViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/27.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "NewsViewController.h"
#import "NetworkDataCenter.h"
#import "AlertCenter.h"
#import "NewsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NewsDetailViewController.h"


@interface NewsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *newslistArr;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showHUD];
    
    [NetworkDataCenter GET:@"https://api.tianapi.com/wxnew" parameters:@{@"page":@"1",@"word":@"彩票",@"key":@"ccec691455525502cec194483030a12d",@"num":@"20"} authorization:nil needsUpdateTimeoutInterval:NO target:self callBack:@selector(wxnewCallBack:)];
}

- (void)wxnewCallBack:(NSDictionary *)dic
{
    [self hideHUD];
    
    if ([dic[@"code"] integerValue] == 200)
    {
        self.newslistArr = [dic objectForKey:@"newslist"];
        
        [self.tableview reloadData];
    }else
    {
        __weak typeof(self) weakself = self;
        [AlertCenter showWithTitle:@"加载数据失败" message:nil cancleButtonTitle:@"重新加载" cancleBlock:^(UIAlertAction * _Nullable action) {
            
            [weakself showHUD];
            
            [NetworkDataCenter GET:@"https://api.tianapi.com/wxnew" parameters:@{@"page":@"1",@"word":@"彩票",@"key":@"ccec691455525502cec194483030a12d",@"num":@"20"} authorization:nil needsUpdateTimeoutInterval:NO target:weakself callBack:@selector(wxnewCallBack:)];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newslistArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.newslistArr[indexPath.row][@"title"];
    cell.descriptionLabel.text = self.newslistArr[indexPath.row][@"description"];
    
    [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:self.newslistArr[indexPath.row][@"picUrl"]] placeholderImage:nil];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self pushViewController:[[NewsDetailViewController alloc] init] param:self.newslistArr[indexPath.row][@"url"] animated:YES];
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
