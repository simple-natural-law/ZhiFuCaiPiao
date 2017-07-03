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
    LotteryTrendTypePl3  = 4,    // 排列3走势图
    LotteryTrendTypePl5  = 5,    // 排列5走势图
    LotteryTrendType3D   = 6,    // 福彩3D
    LotteryTrendTypeSsc  = 7,    // 时时彩
    LotteryTrendTypeK3   = 8,    // 快3
    LotteryTrendType11x5 = 9,    // 11选5
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
    LotteryTrendStylePl3One     = 12,   // 排列3百位
    LotteryTrendStylePl3Two     = 13,   // 排列3十位
    LotteryTrendStylePl3Three   = 14,   // 排列3个位
    LotteryTrendStylePl5One     = 15,   // 排列5万位
    LotteryTrendStylePl5Two     = 16,   // 排列5千位
    LotteryTrendStylePl5Three   = 17,   // 排列5百位
    LotteryTrendStylePl5Four    = 18,   // 排列5十位
    LotteryTrendStylePl5Five    = 19    // 排列5个位
};


@interface LotteryTrendView : UIView

- (instancetype)initWithFrame:(CGRect)frame type:(LotteryTrendType)type style:(LotteryTrendStyle)style dataArray:(NSArray *)dataArray;

- (void)displayWithType:(LotteryTrendType)type style:(LotteryTrendStyle)style dataArray:(NSArray *)dataArray;

@end
