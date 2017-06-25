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
};

typedef NS_ENUM(NSInteger,LotteryTrendStyle) {
    LotteryTrendStyleSsqRed  = 0,    // 双色球红球
    LotteryTrendStyleSsqBlue = 1,    // 双色球蓝球
};


@interface LotteryTrendView : UIView

- (instancetype)initWithFrame:(CGRect)frame type:(LotteryTrendType)type style:(LotteryTrendStyle)style dataArray:(NSArray *)dataArray;

- (void)displayWithType:(LotteryTrendType)type style:(LotteryTrendStyle)style dataArray:(NSArray *)dataArray;

@end
