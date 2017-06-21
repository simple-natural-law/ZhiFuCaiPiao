//
//  BaseViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/13.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "BaseViewController.h"
#import "NetworkDataCenter.h"


@interface BaseViewController ()
{
    __weak id mWeakSelf; ///< 用于取消网络请求
}

@end

@implementation BaseViewController

- (void)dealloc
{
#ifdef DEBUG_MODE
    NSLog(@"\n *** dealloc *** : %@", self);
#endif
    [NetworkDataCenter cancelRequestWithTarget:mWeakSelf]; //取消网络请求
    mWeakSelf = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLOR_BACKGROUND;
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
    mWeakSelf = self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.hidesBottomBarWhenPushed = YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.navigationController.viewControllers.count == 2)
    {
        self.hidesBottomBarWhenPushed = NO;
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
