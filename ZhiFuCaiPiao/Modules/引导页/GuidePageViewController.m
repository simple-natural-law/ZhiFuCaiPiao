//
//  GuidePageViewController.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/28.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "GuidePageViewController.h"
#import "NetworkDataCenter.h"
#import "ErrorViewController.h"


@interface GuidePageViewController ()

@property (nonatomic, strong) UIScrollView *scrollview;

@end


@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollview = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.scrollview];
    self.scrollview.contentSize = CGSizeMake(kScreenWidth * 4, kScreenHeight);
    self.scrollview.pagingEnabled = YES;
    self.scrollview.bounces = NO;
    self.scrollview.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < 4; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d",i+1]];
        [self.scrollview addSubview:imageView];
        
        if (i == 3)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame     = CGRectMake(kScreenWidth*3.5 - 80, kScreenHeight - 50, 160, 40);
            [button setTitle:@"点此进入" forState:UIControlStateNormal];
            [button setTitle:@"点此进入" forState:UIControlStateHighlighted];
            UIColor *textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
            [button setTitleColor:textColor forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.7] forState:UIControlStateHighlighted];
            button.layer.borderWidth = 1;
            button.layer.borderColor = textColor.CGColor;
            button.layer.cornerRadius = 3.0;
            [button addTarget:self action:@selector(goMainPage) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollview addSubview:button];
            
            imageView.tag = 80000;
            button.tag    = 80001;
        }
    }
}


- (void)goMainPage
{
    UIView *imageViewPic = [self.scrollview viewWithTag:80000];
    UIView *button = [self.scrollview viewWithTag:80001];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        /* 改变透明度, 并重新指定跟视图 */
        imageViewPic.alpha = 0.1;
        button.alpha       = 0.1;
        
    } completion:^(BOOL finished) {
        /* 重新指定跟视图 */
        if (finished)
        {
            if (self.toIndex == 1)
            {
                [UIApplication sharedApplication].delegate.window.rootViewController = [UIViewController getViewControllerFormStoryboardName:@"Main" key:@"TabBarViewController"];
            }else if (self.toIndex == 2)
            {
                ErrorViewController *errorVC = [[ErrorViewController alloc] init];
                errorVC.param = self.param;
                [UIApplication sharedApplication].delegate.window.rootViewController = errorVC;
            }
        }
    }];
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
