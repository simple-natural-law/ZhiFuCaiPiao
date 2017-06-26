//
//  LotteryTrendTypeSelectView.h
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/26.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectedBlock)(NSInteger index);

@interface LotteryTrendTypeSelectView : UIView

@property (nonatomic, assign) BOOL isShow;

+ (instancetype)showInView:(UIView *)view didSelectedBlock:(DidSelectedBlock)block;

- (void)show;

- (void)hide;

@end
