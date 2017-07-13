//
//  OtherViewController.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/27.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "UserCenterViewController.h"


@interface UserCenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation UserCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createAndSetRightButtonWithTitle:@"登录" touchUpInsideAction:@selector(login)];
}

- (void)login
{
    [self presentViewController:[UIViewController getViewControllerFormStoryboardName:@"Login" key:@"LoginNaviViewController"] animated:YES completion:nil];
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
