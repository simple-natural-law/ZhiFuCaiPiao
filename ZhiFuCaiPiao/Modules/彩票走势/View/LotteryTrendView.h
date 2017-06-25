//
//  LotteryTrendView.h
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/23.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,LotteryTrendType) {
    LotteryTrendTypeSsq  = 0,    // 双色球走势图
    LotteryTrendTypeDlt  = 1,    // 大乐透走势图
    LotteryTrendTypeQlc  = 2,    // 七乐彩走势图
    LotteryTrendTypeQxc  = 3,    // 七星彩走势图
};

typedef NS_ENUM(NSInteger,LotteryTrendStyle) {
    LotteryTrendStyleSsqRed     = 0,    // 双色球红球
    LotteryTrendStyleSsqBlue    = 1,    // 双色球蓝球
    LotteryTrendStyleDltInFront = 2,    // 大乐透前区走势
    LotteryTrendStyleDltBack    = 3,    // 大乐透后区走势
    LotteryTrendStyleQlc        = 4,    // 七乐彩走势
    LotteryTrendStyleQxcOne     = 5,    // 七星彩第一位
    LotteryTrendStyleQxcTwo     = 6,    // 七星彩第二位
    LotteryTrendStyleQxcThree   = 7,    // 七星彩第三位
    LotteryTrendStyleQxcFour    = 8,    // 七星彩第四位
    LotteryTrendStyleQxcFive    = 9,    // 七星彩第五位
    LotteryTrendStyleQxcSix     = 10,   // 七星彩第六位
    LotteryTrendStyleQxcSeven   = 11,   // 七星彩第七位
};


@interface LotteryTrendView : UIView

- (instancetype)initWithFrame:(CGRect)frame type:(LotteryTrendType)type style:(LotteryTrendStyle)style dataArray:(NSArray *)dataArray;

- (void)displayWithType:(LotteryTrendType)type style:(LotteryTrendStyle)style dataArray:(NSArray *)dataArray;

@end
