//
//  GWCMenuView.h
//  GongWuChe_iOS_passenger
//
//  Created by 讯心科技 on 17/3/18.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPMenuItem.h"

@class CPMenuView;

@protocol CPMenuViewDelegate <NSObject>
@optional
///选中item后执行
- (void)menuView:(CPMenuView *)menuView didSelectIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex;
///返回每个item的宽度
- (CGFloat)menuView:(CPMenuView *)menuView widthForItemAtIndex:(NSInteger)index;
///返回每个item的间距
- (CGFloat)itemsMarginOfMenuView:(CPMenuView *)menuView;
///返回不同状态下的字体颜色
- (UIColor *)menuView:(CPMenuView *)menuView titleColorForItemState:(CPMenuItemState)state;
///返回不同状态下的字体
- (UIFont *)menuView:(CPMenuView *)menuView textFontForItemState:(CPMenuItemState)state;

@end

@protocol CPMenuViewDataSource <NSObject>
@required
///返回item总数
- (NSInteger)itemsCountOfMenuView:(CPMenuView *)menuView;
///根据item下标返回标题
- (NSString *)menuView:(CPMenuView *)menuView titleAtIndex:(NSInteger)index;

@end



@interface CPMenuView : UIView

// 进度条颜色
@property (nonatomic, strong) UIColor *lineColor;

// 进度条高度
@property (nonatomic, assign) CGFloat progressHeight;

@property (nonatomic, weak) id<CPMenuViewDelegate> delegate;

@property (nonatomic, weak) id<CPMenuViewDataSource> dataSource;

@property (nonatomic, assign) NSInteger originIndex;
    
@property (nonatomic, assign, readonly) NSInteger currentIndex;

// 是否显示进度条 默认为yes
@property (nonatomic, assign) BOOL isShowProgress;

- (void)selectedItemAtIndex:(int)index;

@end
