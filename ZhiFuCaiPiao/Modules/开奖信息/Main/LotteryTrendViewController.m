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
#import "LotteryBettingViewController.h"


@interface LotteryTrendViewController ()<CPMenuViewDelegate,CPMenuViewDataSource>

@property (nonatomic, strong) LotteryTrendView *trendView;

@property (nonatomic, strong) LotteryTrendTypeSelectView *typeView;

@property (nonatomic, strong) CPMenuView *menuView;

@property (nonatomic, assign) LotteryTrendType type;

@property (nonatomic, strong) NSArray *dataArr; // 双色球

@end


@implementation LotteryTrendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createAndSetRightButtonWithTitle:@"投注" touchUpInsideAction:@selector(goTouzhu)];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.93 blue:0.87 alpha:1.0];
    
    self.automaticallyAdjustsScrollViewInsets = NO; // 关闭scrollview自动适应
    
    self.type  = [self.param[@"type"] integerValue];
    self.title = self.param[@"title"];
    
    [self addMenuView];
    
    LineView *topLine = [[LineView alloc] initWithFrame:CGRectMake(0, 119, kScreenWidth, 1.0)];
    topLine.lineColor = [UIColor colorWithHexString:@"#cccccc"];
    topLine.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLine];
    
    LineView *bottomLine = [[LineView alloc] initWithFrame:CGRectMake(0, kScreenHeight-83, kScreenWidth, 1.0)];
    bottomLine.lineColor = [UIColor colorWithHexString:@"#cccccc"];
    bottomLine.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomLine];
    
    [self requestData];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)addMenuView
{
    [self.menuView removeFromSuperview];
    self.menuView = [[CPMenuView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 35)];
    self.menuView.delegate   = self;
    self.menuView.dataSource = self;
    self.menuView.lineColor  = COLOR_RED;
    self.menuView.originIndex = 0;
    [self.view insertSubview:self.menuView atIndex:0];
}

- (void)requestData
{
    [self showHUD];
    [NetworkDataCenter GET:@"http://api.caipiao.163.com/missNumber_trend.html" parameters:@{@"product":@"caipiao_client",@"mobileType":@"iphone",@"ver":@"4.33",@"channel":@"appstore",@"apiVer":@"1.1",@"apiLevel":@"27",@"deviceId":[UIDevice UDID],@"gameEn":self.param[@"en"]} authorization:nil needsUpdateTimeoutInterval:NO target:self callBack:@selector(numberTrendCallBack:)];
}


// 双色球
- (void)numberTrendCallBack:(NSDictionary *)result
{
    [self hideHUD];
    
    if ([result[@"result"] integerValue] == 100)
    {
        self.dataArr = [result[@"data"] subarrayWithRange:NSMakeRange(0, 50)];
        
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
        
        for (NSDictionary *dic in self.dataArr)
        {
            @autoreleasepool {
                NSMutableDictionary *dataDic = [dic mutableCopy];
                
                switch (self.type)
                {
                    case LotteryTrendTypeSsq:
                    {
                        NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"general"] subarrayWithRange:NSMakeRange(0, 33)];
                        [dataDic setObject:missNumArr forKey:@"missNumber"];
                        
                        NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(0, 6)];
                        [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                        
                        [dataArray addObject:dataDic];
                    }
                        break;
                    case LotteryTrendTypeDlt:
                    {
                        NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"general"] subarrayWithRange:NSMakeRange(0, 35)];
                        [dataDic setObject:missNumArr forKey:@"missNumber"];
                        
                        NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(0, 5)];
                        [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                        
                        [dataArray addObject:dataDic];
                    }
                        break;
                    case LotteryTrendTypeQlc:
                    {
                        NSArray *missNumArr = [[dic objectForKey:@"missNumber"] objectForKey:@"general"];
                        [dataDic setObject:missNumArr forKey:@"missNumber"];
                        
                        [dataArray addObject:dataDic];
                    }
                        break;
                    case LotteryTrendTypeQxc:
                    {
                        NSArray *missNumArr = [[dic objectForKey:@"missNumber"] objectForKey:@"num1_general"];
                        [dataDic setObject:missNumArr forKey:@"missNumber"];
                        NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(0, 1)];
                        [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                        [dataArray addObject:dataDic];
                    }
                        break;
                    case LotteryTrendTypePl3:
                    {
                        NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"zhixuanfushi"] subarrayWithRange:NSMakeRange(0, 10)];
                        [dataDic setObject:missNumArr forKey:@"missNumber"];
                        NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(0, 1)];
                        [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                        [dataArray addObject:dataDic];
                    }
                        break;
                    case LotteryTrendTypePl5:
                    {
                        NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"zhixuanfushi"] subarrayWithRange:NSMakeRange(0, 10)];
                        [dataDic setObject:missNumArr forKey:@"missNumber"];
                        NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(0, 1)];
                        [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                        [dataArray addObject:dataDic];
                    }
                        break;
                    case LotteryTrendType3D:
                    {
                        
                    }
                        break;
                    case LotteryTrendTypeSsc:
                    {
                        
                    }
                        break;
                    case LotteryTrendTypeK3:
                    {
                        
                    }
                        break;
                    case LotteryTrendType11x5:
                    {
                        
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }
        self.trendView = [[LotteryTrendView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, kScreenHeight-203) type:self.type style:[self getDefaultStyle] dataArray:dataArray];
        [self.view addSubview:self.trendView];
    }
}

- (LotteryTrendStyle)getDefaultStyle
{
    switch (self.type)
    {
        case LotteryTrendTypeSsq:
            return LotteryTrendStyleSsqRed;
            break;
        case LotteryTrendTypeDlt:
            return LotteryTrendStyleDltInFront;
            break;
        case LotteryTrendTypeQlc:
            return LotteryTrendStyleQlc;
            break;
        case LotteryTrendTypeQxc:
            return LotteryTrendStyleQxcOne;
            break;
        case LotteryTrendTypePl3:
            return LotteryTrendStylePl3One;
            break;
        case LotteryTrendTypePl5:
            return LotteryTrendStylePl5One;
            break;
        case LotteryTrendType3D:
            return LotteryTrendStyleSsqRed;
            break;
        case LotteryTrendTypeSsc:
            return LotteryTrendStyleSsqRed;
            break;
        case LotteryTrendTypeK3:
            return LotteryTrendStyleSsqRed;
            break;
        case LotteryTrendType11x5:
            return LotteryTrendStyleSsqRed;
            break;
        default:
            return LotteryTrendStyleSsqRed;
            break;
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
            
            for (NSDictionary *dic in self.dataArr)
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
            
            for (NSDictionary *dic in self.dataArr)
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
            
            for (NSDictionary *dic in self.dataArr)
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
            
            for (NSDictionary *dic in self.dataArr)
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
        
        for (NSDictionary *dic in self.dataArr)
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
        
    }else if (self.type == LotteryTrendTypePl3)
    {
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
        
        LotteryTrendStyle style = LotteryTrendStylePl3One;
        
        NSInteger location = 0;
        
        switch (index)
        {
            case 0:
                location = 0;
                style = LotteryTrendStylePl3One;
                break;
            case 1:
                location = 1;
                style = LotteryTrendStylePl3Two;
                break;
            case 2:
                location = 2;
                style = LotteryTrendStylePl3Three;
                break;
            default:
                break;
        }

        for (NSDictionary *dic in self.dataArr)
        {
            @autoreleasepool {
                NSMutableDictionary *dataDic = [dic mutableCopy];
                NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"zhixuanfushi"] subarrayWithRange:NSMakeRange(location*10, 10)];
                [dataDic setObject:missNumArr forKey:@"missNumber"];
                NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(location, 1)];
                [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                [dataArray addObject:dataDic];
            }
        }
        [self.trendView displayWithType:LotteryTrendTypePl3 style:style dataArray:dataArray];
        
    }else if (self.type == LotteryTrendTypePl5)
    {
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
        
        LotteryTrendStyle style = LotteryTrendStylePl5One;
        
        NSInteger location = 0;
        
        switch (index)
        {
            case 0:
                location = 0;
                style = LotteryTrendStylePl5One;
                break;
            case 1:
                location = 1;
                style = LotteryTrendStylePl5Two;
                break;
            case 2:
                location = 2;
                style = LotteryTrendStylePl5Three;
                break;
            case 3:
                location = 3;
                style = LotteryTrendStylePl5Four;
                break;
            case 4:
                location = 4;
                style = LotteryTrendStylePl5Five;
                break;
            default:
                break;
        }
        
        for (NSDictionary *dic in self.dataArr)
        {
            @autoreleasepool {
                NSMutableDictionary *dataDic = [dic mutableCopy];
                NSArray *missNumArr = [[[dic objectForKey:@"missNumber"] objectForKey:@"zhixuanfushi"] subarrayWithRange:NSMakeRange(location*10, 10)];
                [dataDic setObject:missNumArr forKey:@"missNumber"];
                NSArray *winnerNumberArr = [[dic objectForKey:@"winnerNumber"] subarrayWithRange:NSMakeRange(location, 1)];
                [dataDic setObject:winnerNumberArr forKey:@"winnerNumber"];
                [dataArray addObject:dataDic];
            }
        }
        
        [self.trendView displayWithType:LotteryTrendTypePl5 style:style dataArray:dataArray];
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
    }else if (self.type == LotteryTrendTypePl3)
    {
        return 3;
    }else if (self.type == LotteryTrendTypePl5)
    {
        return 5;
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
    }else if (self.type == LotteryTrendTypePl3)
    {
        switch (index)
        {
            case 0:
                return @"百位";
                break;
            case 1:
                return @"十位";
                break;
            case 2:
                return @"个位";
                break;
            default:
                break;
        }
    }else if (self.type == LotteryTrendTypePl5)
    {
        switch (index)
        {
            case 0:
                return @"万位";
                break;
            case 1:
                return @"千位";
                break;
            case 2:
                return @"百位";
                break;
            case 3:
                return @"十位";
                break;
            case 4:
                return @"个位";
                break;
            default:
                break;
        }
    }
    return @"";
}


- (void)goTouzhu
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
