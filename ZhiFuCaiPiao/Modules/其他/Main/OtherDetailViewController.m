//
//  OtherDetailViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/27.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "OtherDetailViewController.h"

@interface OtherDetailViewController ()

@end

@implementation OtherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isShowHUD = NO;
    
    self.title = self.param[@"title"];

    NSURL *url = [[NSBundle mainBundle] URLForResource:self.param[@"html"] withExtension:nil];
    
    [self loadURL:url param:nil];
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
