//
//  LotteryTrendTypeSelectView.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/26.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryTrendTypeSelectView.h"

@interface LotteryTrendTypeSelectView ()

@property (nonatomic, strong) UIView *customView;

@property (nonatomic, strong) UIControl *background;

@property (nonatomic, weak) UIView *superView;

@end


@implementation LotteryTrendTypeSelectView

+ (instancetype)showInView:(UIView *)view
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    LotteryTrendTypeSelectView *typeView = [[LotteryTrendTypeSelectView alloc] initWithCustomView:contentView superView:view];
    
    [typeView show];
    
    return typeView;
}


- (instancetype)initWithCustomView:(UIView *)customView superView:(UIView *)view
{
    self = [super init];
    
    if (self)
    {
        self.isShow = NO;
        self.superView = view;
        self.frame = CGRectMake(0, 64, view.width, view.height-64);
        self.background  = [[UIControl alloc]initWithFrame:self.bounds];
        self.background.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.6];
        self.background.alpha = 0.0;
        [self.background addTarget:self action:@selector(onBackgroundTouch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.background];
        
        self.customView  = customView;
        customView.frame = CGRectMake(0, -customView.height, customView.width, customView.height);
        [self addSubview:customView];
    }
    return self;
}

- (void)onBackgroundTouch
{
    [self hide];
}


- (void)show
{
    [self.superView addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.customView.transform = CGAffineTransformMakeTranslation(0, 100);
        self.background.alpha = 1.0;
    }];
    
    self.isShow = YES;
}

- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.customView.transform = CGAffineTransformIdentity;
        self.background.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        if (finished)
        {
            [self removeFromSuperview];
        }
    }];
    
    self.isShow = NO;
}


@end
