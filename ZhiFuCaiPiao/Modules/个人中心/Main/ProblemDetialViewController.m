//
//  ProblemDetialViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/7/13.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "ProblemDetialViewController.h"

@interface ProblemDetialViewController ()

@end

@implementation ProblemDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
