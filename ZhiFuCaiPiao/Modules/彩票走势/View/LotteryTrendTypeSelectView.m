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

@property (nonatomic, assign) NSInteger selecedIndex;

@property (nonatomic, copy) DidSelectedBlock block;

@end


@implementation LotteryTrendTypeSelectView

+ (instancetype)showInView:(UIView *)view didSelectedBlock:(DidSelectedBlock)block
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = (kScreenWidth-90.0)/2.0;
    
    UIColor *normalColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame     = CGRectMake(30.0, 20, width, 30);
    [button1 setTitle:@"双色球" forState:UIControlStateNormal];
    [button1 setTitle:@"双色球" forState:UIControlStateSelected];
    [button1 setTitleColor:normalColor forState:UIControlStateNormal];
    [button1 setTitleColor:COLOR_RED forState:UIControlStateSelected];
    button1.layer.borderColor  = COLOR_RED.CGColor;
    button1.layer.borderWidth  = 1.0;
    button1.layer.cornerRadius = 2.0;
    button1.tag = 40000;
    button1.selected = YES;
    [contentView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame     = CGRectMake(60.0+width, 20, width, 30);
    [button2 setTitle:@"大乐透" forState:UIControlStateNormal];
    [button2 setTitle:@"大乐透" forState:UIControlStateSelected];
    [button2 setTitleColor:normalColor forState:UIControlStateNormal];
    [button2 setTitleColor:COLOR_RED forState:UIControlStateSelected];
    button2.layer.borderColor  = normalColor.CGColor;
    button2.layer.borderWidth  = 1.0;
    button2.layer.cornerRadius = 2.0;
    button2.tag = 40001;
    button2.selected = NO;
    [contentView addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame     = CGRectMake(30.0, 60, width, 30);
    [button3 setTitle:@"七乐彩" forState:UIControlStateNormal];
    [button3 setTitle:@"七乐彩" forState:UIControlStateSelected];
    [button3 setTitleColor:normalColor forState:UIControlStateNormal];
    [button3 setTitleColor:COLOR_RED forState:UIControlStateSelected];
    button3.layer.borderColor  = normalColor.CGColor;
    button3.layer.borderWidth  = 1.0;
    button3.layer.cornerRadius = 2.0;
    button3.tag = 40002;
    button3.selected = NO;
    [contentView addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame     = CGRectMake(60.0+width, 60, width, 30);
    [button4 setTitle:@"七星彩" forState:UIControlStateNormal];
    [button4 setTitle:@"七星彩" forState:UIControlStateSelected];
    [button4 setTitleColor:normalColor forState:UIControlStateNormal];
    [button4 setTitleColor:COLOR_RED forState:UIControlStateSelected];
    button4.layer.borderColor  = normalColor.CGColor;
    button4.layer.borderWidth  = 1.0;
    button4.layer.cornerRadius = 2.0;
    button4.tag = 40003;
    button4.selected = NO;
    [contentView addSubview:button4];
    
    LotteryTrendTypeSelectView *typeView = [[LotteryTrendTypeSelectView alloc] initWithCustomView:contentView superView:view didSelectedBlock:block];
    
    typeView.selecedIndex = 40000;
    [button1 addTarget:typeView action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:typeView action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:typeView action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [button4 addTarget:typeView action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [typeView show];
    
    return typeView;
}


- (void)didClickButton:(UIButton *)button
{
    [self hide];
    
    if (button.selected)
    {
        return;
    }
    button.layer.borderColor = COLOR_RED.CGColor;
    button.selected = YES;
    
    UIButton *selectedButton = [self.customView viewWithTag:self.selecedIndex];
    selectedButton.selected = NO;
    selectedButton.layer.borderColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor;
    
    self.selecedIndex = button.tag;
    
    if (self.block)
    {
        self.block(self.selecedIndex);
    }
}


- (instancetype)initWithCustomView:(UIView *)customView superView:(UIView *)view didSelectedBlock:(DidSelectedBlock)block
{
    self = [super init];
    
    if (self)
    {
        self.block = block;
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
