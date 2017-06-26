//
//  LotteryTrendViewController.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/15.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryTrendViewController.h"
#import "NetworkDataCenter.h"
#import "LotteryTrendView.h"
#import "CPMenuView.h"
#import "LineView.h"
#import "LotteryTrendTypeSelectView.h"


@interface LotteryTrendViewController ()<CPMenuViewDelegate,CPMenuViewDataSource>

@property (nonatomic, strong) LotteryTrendView *trendView;

@property (nonatomic, strong) LotteryTrendTypeSelectView *typeView;

@property (nonatomic, strong) CPMenuView *menuView;

@property (nonatomic, assign) LotteryTrendType type;

@property (nonatomic, strong) NSArray *ssqDataArr; // 双色球
@property (nonatomic, strong) NSArray *dltDataArr; // 大乐透
@property (nonatomic, strong) NSArray *qlcDataArr; // 七星彩
@property (nonatomic, strong) NSArray *qxcDataArr; // 七乐彩

@end


@implementation LotteryTrendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.93 blue:0.87 alpha:1.0];
    
    [self createAndSetRightButtonWithNormalImage:[UIImage imageNamed:@"select_lottery_type"] highlightedImage:[UIImage imageNamed:@"select_lottery_type_highlighted"] touchUpInsideAction:@selector(selectedLotteryType)];
    
    self.automaticallyAdjustsScrollViewInsets = NO; // 关闭scrollview自动适应
    
    self.type = LotteryTrendTypeSsq;
    
    self.menuView = [[CPMenuView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 35)];
    self.menuView.delegate   = self;
    self.menuView.dataSource = self;
    self.menuView.lineColor  = COLOR_RED;
    self.menuView.originIndex = 0;
    [self.view addSubview:self.menuView];
    
    LineView *line = [[LineView alloc] initWithFrame:CGRectMake(0, 119, kScreenWidth, 1.0)];
    line.lineColor = [UIColor colorWithHexString:@"#cccccc"];
    line.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line];
    
    [self requestSsqData];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)requestSsqData
{
    [self showHUD];
    [NetworkDataCenter GET:@"http://api.caipiao.163.com/missNumber_trend.html" parameters:@{@"product":@"caipiao_client",@"mobileType":@"iphone",@"ver":@"4.33",@"channel":@"appstore",@"apiVer":@"1.1",@"apiLevel":@"27",@"deviceId":[UIDevice UDID],@"gameEn":@"ssq"} authorization:nil target:self callBack:@selector(ssqNumberTrendCallBack:)];
}

- (void)requestDltData
{
    [self showHUD];
    [NetworkDataCenter GET:@"http://api.caipiao.163.com/missNumber_trend.html" parameters:@{@"product":@"caipiao_client",@"mobileType":@"iphone",@"ver":@"4.33",@"channel":@"appstore",@"apiVer":@"1.1",@"apiLevel":@"27",@"deviceId":[UIDevice UDID],@"gameEn":@"dlt"} authorization:nil target:self callBack:@selector(dltNumberTrendCallBack:)];
}

- (void)requestQlcData
{
    [self showHUD];
    [NetworkDataCenter GET:@"http://api.caipiao.163.com/missNumber_trend.html" parameters:@{@"product":@"caipiao_client",@"mobileType":@"iphone",@"ver":@"4.33",@"channel":@"appstore",@"apiVer":@"1.1",@"apiLevel":@"27",@"deviceId":[UIDevice UDID],@"gameEn":@"qlc"} authorization:nil target:self callBack:@selector(qlcNumberTrendCallBack:)];
}

- (void)requestQxcData
{
    [self showHUD];
    [NetworkDataCenter GET:@"http://api.caipiao.163.com/missNumber_trend.html" parameters:@{@"product":@"caipiao_client",@"mobileType":@"iphone",@"ver":@"4.33",@"channel":@"appstore",@"apiVer":@"1.1",@"apiLevel":@"27",@"deviceId":[UIDevice UDID],@"gameEn":@"qxc"} authorization:nil target:self callBack:@selector(qxcNumberTrendCallBack:)];
}


// 双色球
- (void)ssqNumberTrendCallBack:(NSDictionary *)result
{
    [self hideHUD];
    
    self.ssqDataArr = [result[@"data"] subarrayWithRange:NSMakeRange(0, 50)];
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
    
    for (NSDictionary *dic in self.ssqDataArr)
    {
        @autoreleasepool {
            NSMutableDictionary *dataDic = [dic mutableCopy];
            NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"general"] subarrayWithRange:NSMakeRange(0, 33)];
            [dataDic setObject:missNumArr forKey:@"missNumber"];
            
            NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(0, 6)];
            [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
            
            [dataArray addObject:dataDic];
        }
    }
    self.trendView = [[LotteryTrendView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, kScreenHeight-213) type:LotteryTrendTypeSsq style:LotteryTrendStyleSsqRed dataArray:dataArray];
    [self.view addSubview:self.trendView];
}

// 大乐透
- (void)dltNumberTrendCallBack:(NSDictionary *)result
{
    [self hideHUD];
    
    self.dltDataArr = [result[@"data"] subarrayWithRange:NSMakeRange(0, 50)];
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
    
    for (NSDictionary *dic in self.dltDataArr)
    {
        @autoreleasepool {
            NSMutableDictionary *dataDic = [dic mutableCopy];
            NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"general"] subarrayWithRange:NSMakeRange(0, 35)];
            [dataDic setObject:missNumArr forKey:@"missNumber"];
            
            NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(0, 5)];
            [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
            
            [dataArray addObject:dataDic];
        }
    }
    [self.trendView displayWithType:LotteryTrendTypeDlt style:LotteryTrendStyleDltInFront dataArray:dataArray];
}

// 七乐彩
- (void)qlcNumberTrendCallBack:(NSDictionary *)result
{
    [self hideHUD];
    
    self.qlcDataArr = [result[@"data"] subarrayWithRange:NSMakeRange(0, 50)];
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
    
    for (NSDictionary *dic in self.qlcDataArr)
    {
        @autoreleasepool {
            NSMutableDictionary *dataDic = [dic mutableCopy];
            NSArray *missNumArr = [[dic objectForKey:@"missNumber"] objectForKey:@"general"];
            [dataDic setObject:missNumArr forKey:@"missNumber"];
            
            [dataArray addObject:dataDic];
        }
    }
    
    [self.trendView displayWithType:LotteryTrendTypeQlc style:LotteryTrendStyleQlc dataArray:dataArray];
}

// 七星彩
- (void)qxcNumberTrendCallBack:(NSDictionary *)result
{
    [self hideHUD];
    
    self.qxcDataArr = [result[@"data"] subarrayWithRange:NSMakeRange(0, 50)];
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
    
    for (NSDictionary *dic in self.qxcDataArr)
    {
        @autoreleasepool {
            NSMutableDictionary *dataDic = [dic mutableCopy];
            NSArray *missNumArr = [[dic objectForKey:@"missNumber"] objectForKey:@"num1_general"];
            [dataDic setObject:missNumArr forKey:@"missNumber"];
            NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(0, 1)];
            [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
            [dataArray addObject:dataDic];
        }
    }

    [self.trendView displayWithType:LotteryTrendTypeQxc style:LotteryTrendStyleQxcOne dataArray:dataArray];
}

- (void)selectedLotteryType
{
    if (self.typeView == nil)
    {
       self.typeView = [LotteryTrendTypeSelectView showInView:self.view];
    }else
    {
        if (self.typeView.isShow)
        {
            [self.typeView hide];
        }else
        {
            [self.typeView show];
        }
    }
}

#pragma mark- GWCMenuViewDelegate
- (void)menuView:(CPMenuView *)menuView didSelectIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex
{
    if (self.type == LotteryTrendTypeSsq)  // 双色球
    {
        if (index == 0)
        {
            NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
            
            for (NSDictionary *dic in self.ssqDataArr)
            {
                @autoreleasepool {
                    NSMutableDictionary *dataDic = [dic mutableCopy];
                    NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"general"] subarrayWithRange:NSMakeRange(0, 33)];
                    [dataDic setObject:missNumArr forKey:@"missNumber"];
                    
                    NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(0, 6)];
                    [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                    
                    [dataArray addObject:dataDic];
                }
            }
            
            [self.trendView displayWithType:LotteryTrendTypeSsq style:LotteryTrendStyleSsqRed dataArray:dataArray];
        }else
        {
            NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
            
            for (NSDictionary *dic in self.ssqDataArr)
            {
                @autoreleasepool {
                    NSMutableDictionary *dataDic = [dic mutableCopy];
                    NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"general"] subarrayWithRange:NSMakeRange(33, 16)];
                    [dataDic setObject:missNumArr forKey:@"missNumber"];
                    
                    NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(6, 1)];
                    [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                    [dataArray addObject:dataDic];
                }
            }
            
            [self.trendView displayWithType:LotteryTrendTypeSsq style:LotteryTrendStyleSsqBlue dataArray:dataArray];
        }
    }else if (self.type == LotteryTrendTypeDlt) // 大乐透
    {
        if (index == 0)
        {
            NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
            
            for (NSDictionary *dic in self.dltDataArr)
            {
                @autoreleasepool {
                    NSMutableDictionary *dataDic = [dic mutableCopy];
                    NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"general"] subarrayWithRange:NSMakeRange(0, 35)];
                    [dataDic setObject:missNumArr forKey:@"missNumber"];
                    
                    NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(0, 5)];
                    [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                    
                    [dataArray addObject:dataDic];
                }
            }
            
            [self.trendView displayWithType:LotteryTrendTypeDlt style:LotteryTrendStyleDltInFront dataArray:dataArray];
        }else
        {
            NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
            
            for (NSDictionary *dic in self.dltDataArr)
            {
                @autoreleasepool {
                    NSMutableDictionary *dataDic = [dic mutableCopy];
                    NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"general"] subarrayWithRange:NSMakeRange(35, 12)];
                    [dataDic setObject:missNumArr forKey:@"missNumber"];
                    
                    NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(5, 2)];
                    [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                    [dataArray addObject:dataDic];
                }
            }
            [self.trendView displayWithType:LotteryTrendTypeDlt style:LotteryTrendStyleDltBack dataArray:dataArray];
        }
    }else if (self.type == LotteryTrendTypeQxc)
    {
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
        
        NSString *key = nil;
        
        LotteryTrendStyle style = LotteryTrendStyleQxcOne;
        
        switch (index)
        {
            case 0:
                key = @"num1_general";
                style = LotteryTrendStyleQxcOne;
                break;
            case 1:
                key = @"num2_general";
                style = LotteryTrendStyleQxcTwo;
                break;
            case 2:
                key = @"num3_general";
                style = LotteryTrendStyleQxcThree;
                break;
            case 3:
                key = @"num4_general";
                style = LotteryTrendStyleQxcFour;
                break;
            case 4:
                key = @"num5_general";
                style = LotteryTrendStyleQxcFive;
                break;
            case 5:
                key = @"num6_general";
                style = LotteryTrendStyleQxcSix;
                break;
            case 6:
                key = @"num7_general";
                style = LotteryTrendStyleQxcSeven;
                break;
            default:
                key = @"num1_general";
                style = LotteryTrendStyleQxcOne;
                break;
        }
        
        for (NSDictionary *dic in self.qxcDataArr)
        {
            @autoreleasepool {
                
                NSMutableDictionary *dataDic = [dic mutableCopy];
                
                NSArray *missNumArr = [[dic objectForKey:@"missNumber"] objectForKey:key];
                [dataDic setObject:missNumArr forKey:@"missNumber"];
                NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(index, 1)];
                [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                [dataArray addObject:dataDic];
            }
        }
        
        [self.trendView displayWithType:LotteryTrendTypeQxc style:style dataArray:dataArray];
    }
}

- (CGFloat)itemsMarginOfMenuView:(CPMenuView *)menuView
{
    return 10.0;
}

- (CGFloat)menuView:(CPMenuView *)menuView widthForItemAtIndex:(NSInteger)index
{
    if (self.type == LotteryTrendTypeQlc)
    {
        return 100.0;
    }
    return 65.0;
}

- (UIColor *)menuView:(CPMenuView *)menuView titleColorForItemState:(CPMenuItemState)state
{
    if (state == CPMenuItemStateSelected)
    {
        return COLOR_RED;
    }else
    {
        return [UIColor colorWithHexString:@"#333333"];
    }
}

- (UIFont *)menuView:(CPMenuView *)menuView textFontForItemState:(CPMenuItemState)state
{
    return [UIFont systemFontOfSize:15.0];
}

#pragma mark- GWCMenuViewDataSource
- (NSInteger)itemsCountOfMenuView:(CPMenuView *)menuView
{
    if (self.type == LotteryTrendTypeSsq)
    {
        return 2;
    }else if (self.type == LotteryTrendTypeDlt)
    {
        return 2;
    }else if (self.type == LotteryTrendTypeQlc)
    {
        return 1;
    }else if (self.type == LotteryTrendTypeQxc)
    {
        return 7;
    }
    return 0;
}

- (NSString *)menuView:(CPMenuView *)menuView titleAtIndex:(NSInteger)index
{
    if (self.type == LotteryTrendTypeSsq)
    {
        switch (index)
        {
            case 0:
                return @"红球走势";
                break;
            case 1:
                return @"蓝球走势";
                break;
            default:
                return @"";
                break;
        }
    }else if (self.type == LotteryTrendTypeDlt)
    {
        switch (index)
        {
            case 0:
                return @"前区走势";
                break;
            case 1:
                return @"后区走势";
                break;
            default:
                return @"";
                break;
        }
    }else if (self.type == LotteryTrendTypeQlc)
    {
        return @"开奖号码分布";
    }else if (self.type == LotteryTrendTypeQxc)
    {
        switch (index)
        {
            case 0:
                return @"第一位";
                break;
            case 1:
                return @"第二位";
                break;
            case 2:
                return @"第三位";
                break;
            case 3:
                return @"第四位";
                break;
            case 4:
                return @"第五位";
                break;
            case 5:
                return @"第六位";
                break;
            case 6:
                return @"第七位";
                break;
            default:
                break;
        }
    }
    return @"";
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
