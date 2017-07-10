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

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DivinationDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"周易预测-双色球";
    
    [self createAndSetRightButtonWithTitle:@"投注" touchUpInsideAction:@selector(touZhu)];
    
    self.tianGanLabel.text = self.param[@"GuaMing"][@"TianGan"];
    self.diZhiLabel.text   = self.param[@"GuaMing"][@"DiZhi"];
    
    self.tianView1.hidden  = [self.param[@"GuaMing"][@"TianGanXiang"][0] integerValue] == 0;
    self.tianView2.hidden  = [self.param[@"GuaMing"][@"TianGanXiang"][1] integerValue] == 0;
    self.tianView3.hidden  = [self.param[@"GuaMing"][@"TianGanXiang"][2] integerValue] == 0;
    self.tianView4.hidden  = [self.param[@"GuaMing"][@"TianGanXiang"][3] integerValue] == 0;
    self.tianView5.hidden  = [self.param[@"GuaMing"][@"TianGanXiang"][4] integerValue] == 0;
    self.tianView6.hidden  = [self.param[@"GuaMing"][@"TianGanXiang"][5] integerValue] == 0;
    
    self.diView1.hidden    = [self.param[@"GuaMing"][@"DiZhiXiang"][0] integerValue] == 0;
    self.diView2.hidden    = [self.param[@"GuaMing"][@"DiZhiXiang"][1] integerValue] == 0;
    self.diView3.hidden    = [self.param[@"GuaMing"][@"DiZhiXiang"][2] integerValue] == 0;
    self.diView4.hidden    = [self.param[@"GuaMing"][@"DiZhiXiang"][3] integerValue] == 0;
    self.diView5.hidden    = [self.param[@"GuaMing"][@"DiZhiXiang"][4] integerValue] == 0;
    self.diView6.hidden    = [self.param[@"GuaMing"][@"DiZhiXiang"][5] integerValue] == 0;
    
//    CGFloat height = [self.param[@"GuaJie"] boundingRectWithSize:CGSizeMake(kScreenWidth-16.0, 0.0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil].size.height+10.0;
    
    NSString *str = [self.param[@"GuaJie"] stringByReplacingOccurrencesOfString:@"\n" withString:@"\r\n"];
    
    self.textView.text = str;
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
