//
//  DivinationDescriptionViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/7/9.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "DivinationDescriptionViewController.h"
#import "LotteryBettingViewController.h"


@interface DivinationDescriptionViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numViewWidthCons;
@property (weak, nonatomic) IBOutlet UILabel *numLabel1;
@property (weak, nonatomic) IBOutlet UILabel *numLabel2;
@property (weak, nonatomic) IBOutlet UILabel *numLabel3;
@property (weak, nonatomic) IBOutlet UILabel *numLabel4;
@property (weak, nonatomic) IBOutlet UILabel *numLabel5;
@property (weak, nonatomic) IBOutlet UILabel *numLabel6;
@property (weak, nonatomic) IBOutlet UILabel *numLabel7;
@property (weak, nonatomic) IBOutlet UILabel *numLabel8;

@property (weak, nonatomic) IBOutlet UILabel *tianGanLabel;
@property (weak, nonatomic) IBOutlet UIView *tianView1;
@property (weak, nonatomic) IBOutlet UIView *tianView2;
@property (weak, nonatomic) IBOutlet UIView *tianView3;
@property (weak, nonatomic) IBOutlet UIView *tianView4;
@property (weak, nonatomic) IBOutlet UIView *tianView5;
@property (weak, nonatomic) IBOutlet UIView *tianView6;

@property (weak, nonatomic) IBOutlet UILabel *diZhiLabel;
@property (weak, nonatomic) IBOutlet UIView *diView1;
@property (weak, nonatomic) IBOutlet UIView *diView2;
@property (weak, nonatomic) IBOutlet UIView *diView3;
@property (weak, nonatomic) IBOutlet UIView *diView4;
@property (weak, nonatomic) IBOutlet UIView *diView5;
@property (weak, nonatomic) IBOutlet UIView *diView6;

@end

@implementation DivinationDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.param[@"code"] isEqualToString:@"ssq"])
    {
        self.title = @"周易预测-双色球";
    }else if ([self.param[@"code"] isEqualToString:@"dlt"])
    {
        self.title = @"周易预测-大乐透";
    }else if ([self.param[@"code"] isEqualToString:@"qlc"])
    {
        self.title = @"周易预测-七乐彩";
    }else if ([self.param[@"code"] isEqualToString:@"qxc"])
    {
        self.title = @"周易预测-七星彩";
    }else if ([self.param[@"code"] isEqualToString:@"pl3"])
    {
        self.title = @"周易预测-排列3";
    }else
    {
        self.title = @"周易预测-排列5";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createAndSetRightButtonWithTitle:@"投注" touchUpInsideAction:@selector(touZhu)];
    
    NSArray *numberArray1 = self.param[@"NumArr1"];
    NSArray *numberArray2 = self.param[@"NumArr2"];
    
    for (int i = 0; i < numberArray1.count; i++)
    {
        UILabel *label = [self.view viewWithTag:80000+i];
        label.text     = numberArray1[i];
        label.layer.backgroundColor = COLOR_RED.CGColor;
        label.layer.cornerRadius    = 15.0;
    }
    
    NSInteger offset = numberArray1.count;
    
    for (int i = 0; i < numberArray2.count; i++)
    {
        UILabel *label = [self.view viewWithTag:80000+i+offset];
        label.text     = numberArray2[i];
        label.layer.backgroundColor = COLOR_BLUE.CGColor;
        label.layer.cornerRadius    = 15.0;
    }
    
    NSInteger count     = numberArray1.count+numberArray2.count;
    CGFloat totalMargin = (count - 1) > 0 ? (count - 1)*5.0 : 0.0;
    self.numViewWidthCons.constant = count*30.0+totalMargin;
    
    self.tianGanLabel.text = self.param[@"GuaXiang"][@"GuaMing"][@"TianGan"];
    self.diZhiLabel.text   = self.param[@"GuaXiang"][@"GuaMing"][@"DiZhi"];
    
    self.tianView1.hidden  = [self.param[@"GuaXiang"][@"GuaMing"][@"TianGanXiang"][0] integerValue] == 0;
    self.tianView2.hidden  = [self.param[@"GuaXiang"][@"GuaMing"][@"TianGanXiang"][1] integerValue] == 0;
    self.tianView3.hidden  = [self.param[@"GuaXiang"][@"GuaMing"][@"TianGanXiang"][2] integerValue] == 0;
    self.tianView4.hidden  = [self.param[@"GuaXiang"][@"GuaMing"][@"TianGanXiang"][3] integerValue] == 0;
    self.tianView5.hidden  = [self.param[@"GuaXiang"][@"GuaMing"][@"TianGanXiang"][4] integerValue] == 0;
    self.tianView6.hidden  = [self.param[@"GuaXiang"][@"GuaMing"][@"TianGanXiang"][5] integerValue] == 0;
    
    self.diView1.hidden    = [self.param[@"GuaXiang"][@"GuaMing"][@"DiZhiXiang"][0] integerValue] == 0;
    self.diView2.hidden    = [self.param[@"GuaXiang"][@"GuaMing"][@"DiZhiXiang"][1] integerValue] == 0;
    self.diView3.hidden    = [self.param[@"GuaXiang"][@"GuaMing"][@"DiZhiXiang"][2] integerValue] == 0;
    self.diView4.hidden    = [self.param[@"GuaXiang"][@"GuaMing"][@"DiZhiXiang"][3] integerValue] == 0;
    self.diView5.hidden    = [self.param[@"GuaXiang"][@"GuaMing"][@"DiZhiXiang"][4] integerValue] == 0;
    self.diView6.hidden    = [self.param[@"GuaXiang"][@"GuaMing"][@"DiZhiXiang"][5] integerValue] == 0;
    
    NSString *str = [self.param[@"GuaXiang"][@"GuaJie"] stringByReplacingOccurrencesOfString:@"n" withString:@"\r\n" ];
    CGFloat height = [str boundingRectWithSize:CGSizeMake(kScreenWidth-24.0, 0.0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil].size.height+20.0;
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 304, kScreenWidth, kScreenHeight-304)];
    scrollview.contentSize = CGSizeMake(kScreenWidth, height);
    [self.view addSubview:scrollview];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, kScreenWidth-24.0, height - 10)];
    label.font = [UIFont systemFontOfSize:17.0];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.numberOfLines = 0;
    label.text = str;
    [scrollview addSubview:label];
}



#pragma mark-
- (void)touZhu
{
    [self pushViewController:[[LotteryBettingViewController alloc] init] param:@"http://wap.lecai.com/lottery/" animated:YES];
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
