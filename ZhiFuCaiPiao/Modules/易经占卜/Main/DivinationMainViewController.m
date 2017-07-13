//
//  DivinationMainViewController.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/7/6.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "DivinationMainViewController.h"
#import "LotteryTrendTypeSelectView.h"

@interface DivinationMainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *taijiButton;
// 农历年月日
@property (weak, nonatomic) IBOutlet UILabel *chineseYearLabel;
// 年月
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
// 日
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
// 宜
@property (weak, nonatomic) IBOutlet UILabel *yiContentLabel;
// 忌
@property (weak, nonatomic) IBOutlet UILabel *jiContentLabel;

@property (strong, nonatomic) dispatch_source_t animationTimer;

@property (strong, nonatomic) NSString *code;

@end


@implementation DivinationMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createAndSetRightButtonWithNormalImage:[UIImage imageNamed:@"aboutInfo"] highlightedImage:[UIImage imageNamed:@"aboutInfo"] touchUpInsideAction:@selector(seeJieshao)];
    
    [self createAndSetLeftButtonWithNormalImage:[UIImage imageNamed:@"select_lottery_type"] highlightedImage:[UIImage imageNamed:@"select_lottery_type_highlighted"] touchUpInsideAction:@selector(selectedType)];
    
    self.code = @"ssq";
    
    NSDate *date = [NSDate date];
    
    self.dayLabel.text = [NSString stringWithFormat:@"%02ld",[date getDay]];
    self.yearLabel.text = [NSString stringWithFormat:@"%ld.%02ld",[date getYear],[date getMonth]];
    self.chineseYearLabel.text = [NSDate lunarForSolar:date ShowYear:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   
    self.animationTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.animationTimer, DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.animationTimer, ^{
        
        self.taijiButton.transform = CGAffineTransformRotate(self.taijiButton.transform, M_PI/180);
    });
    
    dispatch_resume(self.animationTimer);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    dispatch_source_cancel(self.animationTimer);
    
    self.animationTimer = nil;
}


- (IBAction)goDivination:(id)sender
{
    [self pushViewControllerKey:@"DivinationDetialViewController" param:self.code animated:YES];
}

- (void)selectedType
{
    __weak typeof(self) weakself = self;
    
    [LotteryTrendTypeSelectView showInView:self.view didSelectedBlock:^(NSInteger index) {
        
        switch (index)
        {
            case 0:
            {
                weakself.title = @"易经占卜-双色球";
                weakself.code = @"ssq";
            }
                break;
            case 1:
            {
                weakself.title = @"易经占卜-大乐透";
                weakself.code = @"dlt";
            }
                break;
            case 2:
            {
                weakself.title = @"易经占卜-七乐彩";
                weakself.code = @"qlc";
            }
                break;
            case 3:
            {
                weakself.title = @"易经占卜-七星彩";
                weakself.code = @"qxc";
            }
                break;
            case 4:
            {
                weakself.title = @"易经占卜-排列3";
                weakself.code = @"pl3";
            }
                break;
            case 5:
            {
                weakself.title = @"易经占卜-排列5";
                weakself.code = @"pl5";
            }
                break;
            default:
                break;
        }
    }];
}

- (void)seeJieshao
{
    [self pushViewControllerKey:@"DivinationAboutInfoViewController" param:nil animated:YES];
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
