//
//  LotteryTrendView.h
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/23.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,LotteryTrendType) {
    LotteryTrendTypeSsqRed  = 0,    // 双色球红球走势图
    LotteryTrendTypeSsqBlue = 1,    // 双色球蓝球走势图
};


@interface LotteryTrendView : UIView

- (instancetype)initWithFrame:(CGRect)frame type:(LotteryTrendType)type dataArray:(NSArray *)dataArray;

@end
