//
//  GWCMenuView.m
//  GongWuChe_iOS_passenger
//
//  Created by 讯心科技 on 17/3/18.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "CPMenuView.h"
#import "CPProgressView.h"


static CGFloat const CPMenuViewItemWidth = 50.0;  //item宽度
static CGFloat const CPMenuViewProgressViewHeight = 2.0; // progress高度
static CGFloat const CPMenuViewItemTagOffset = 10086;    // item的tag值起始


@interface CPMenuView ()<CPMenuItemDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) CPProgressView *progressView;

@property (nonatomic, strong) CPMenuItem *selectedItem;

@property (nonatomic, readonly) NSInteger itemsCount;

@property (nonatomic, readonly) UIColor *normalColor;

@property (nonatomic, readonly) UIColor *selectedColor;

@property (nonatomic, strong) NSMutableArray *itemFrames;

@end


@implementation CPMenuView

- (NSMutableArray *)itemFrames
{
    if (_itemFrames == nil)
    {
        _itemFrames = [NSMutableArray array];
    }
    return _itemFrames;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.isShowProgress = YES;
    }
    return self;
}

/// 系统api 在视图将要被添加到父视图时调用
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (self.scrollView) return;
    
    [self addScrollview];
    
    [self addItems];
    
    if (self.isShowProgress)
    {
        [self addProgressView];
    }
}


- (void)addScrollview
{
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.scrollView = [[UIScrollView alloc]initWithFrame:frame];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
}


- (void)addItems
{
    [self calculateItemFrames];
    
    for (int i = 0; i<self.itemsCount; i++)
    {
        CGRect frame = [self.itemFrames[i] CGRectValue];
        
        CPMenuItem *item = [[CPMenuItem alloc]initWithFrame:frame];
        
        [item setTag:CPMenuViewItemTagOffset + i];
        
        if (i == self.originIndex)
        {
            item.selected     = YES;
            self.selectedItem = item;
        }
        
        if ([self.dataSource respondsToSelector:@selector(menuView:titleAtIndex:)])
        {
            item.text = [self.dataSource menuView:self titleAtIndex:i];
        }
        item.normalColor   = self.normalColor;
        item.selectedColor = self.selectedColor;
        item.font          = [self itemFont];
        
        item.delegate = self;
        
        [self.scrollView addSubview:item];
    }
}


- (void)calculateItemFrames
{
    CGFloat width = CPMenuViewItemWidth;
    
    CGFloat margin = [self itemsMargin];
    
    CGFloat originX = margin;
    
    CGFloat height = self.isShowProgress ? self.frame.size.height - CPMenuViewProgressViewHeight : self.frame.size.height;
    
    for (int i = 0; i<self.itemsCount; i++)
    {
        if ([self.delegate respondsToSelector:@selector(menuView:widthForItemAtIndex:)])
        {
            width = [self.delegate menuView:self widthForItemAtIndex:i];
        }
        
        CGRect frame = CGRectMake(originX, 0, width, height);
        
        [self.itemFrames addObject:[NSValue valueWithCGRect:frame]];
        
        originX += width + margin;
    }
    
    CGFloat totalWidth = originX;
    
    // 如果总宽度要小于menuView的宽度  就重新计算frame
    if (totalWidth < self.frame.size.width)
    {
        for (int i = 0; i < self.itemFrames.count; i++)
        {
            CGRect frame = [self.itemFrames[i] CGRectValue];
            
            frame.origin.x += (self.frame.size.width - totalWidth)/2.0;
            
            self.itemFrames[i] = [NSValue valueWithCGRect:frame];
        }
        
        totalWidth = self.frame.size.width;
    }
    
    self.scrollView.contentSize = CGSizeMake(totalWidth, self.frame.size.height);
}


- (void)addProgressView
{
    self.progressView = [[CPProgressView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - CPMenuViewProgressViewHeight, self.scrollView.contentSize.width, CPMenuViewProgressViewHeight)];
    self.progressView.color    = self.lineColor.CGColor;
    self.progressView.backgroundColor = [UIColor clearColor];
    self.progressView.progress = self.originIndex;
    self.progressView.itemFrames = self.itemFrames;
    [self.scrollView addSubview:self.progressView];
}


- (NSInteger)itemsCount
{
    return [self.dataSource itemsCountOfMenuView:self];
}

- (CGFloat)itemsMargin
{
    if ([self.delegate respondsToSelector:@selector(itemsMarginOfMenuView:)])
    {
        return [self.delegate itemsMarginOfMenuView:self];
    }else
    {
        return 0.0;
    }
}


- (UIColor *)normalColor
{
    if ([self.delegate respondsToSelector:@selector(menuView:titleColorForItemState:)])
    {
        return [self.delegate menuView:self titleColorForItemState:CPMenuItemStateNormal];
    }
    
    return [UIColor blackColor];
}

- (UIColor *)selectedColor
{
    if ([self.delegate respondsToSelector:@selector(menuView:titleColorForItemState:)])
    {
        return [self.delegate menuView:self titleColorForItemState:CPMenuItemStateSelected];
    }
    
    return [UIColor greenColor];
}

- (UIFont *)itemFont
{
    if ([self.delegate respondsToSelector:@selector(menuView:textFontForItemState:)])
    {
        return [self.delegate menuView:self textFontForItemState:CPMenuItemStateNormal];
    }
    
    return [UIFont systemFontOfSize:17.0];
}



- (void)selectedItemAtIndex:(int)index
{
    if (index == self.selectedItem.tag - CPMenuViewItemTagOffset) return;
    
    CPMenuItem *item = [self.scrollView viewWithTag:index+CPMenuViewItemTagOffset];
    
    [self didClickMenuItem:item];
}

#pragma mark - SjMenuItemDelegate
- (void)didClickMenuItem:(CPMenuItem *)item
{
    // 原来选中的item取消选中状态
    self.selectedItem.selected = NO;
    
    NSInteger currentIndex = self.selectedItem.tag - CPMenuViewItemTagOffset;
    
    NSInteger selectedIndex = item.tag - CPMenuViewItemTagOffset;
    
    if (self.isShowProgress)
    {
        [self.progressView moveToPosition:selectedIndex];
    }
    
    // 让item处于view的中间
    [self adjustMenuCenterForItem:item];
    
    item.selected = YES;
    
    self.selectedItem = item;
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectIndex:currentIndex:)])
    {
        [self.delegate menuView:self didSelectIndex:selectedIndex currentIndex:currentIndex];
    }
}


// 滑动scrollview，让item处于中间.
- (void)adjustMenuCenterForItem:(CPMenuItem *)item
{
    if (item.frame.origin.x>(self.scrollView.frame.size.width/2.0))
    {
        CGFloat offsetX = item.frame.origin.x- (self.scrollView.frame.size.width/2.0 - item.frame.size.width/2.0);
        
        CGFloat maxOffsetX = self.scrollView.contentSize.width-self.scrollView.frame.size.width;
        
        if (offsetX<=maxOffsetX)
        {
            [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }else
        {
            [self.scrollView setContentOffset:CGPointMake(maxOffsetX, 0) animated:YES];
        }
        
    }else
    {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

    
- (NSInteger)currentIndex
{
    return self.selectedItem.tag - CPMenuViewItemTagOffset;
}
    

@end
