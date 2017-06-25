//
//  GWCMenuItem.m
//  GongWuChe_iOS_passenger
//
//  Created by 讯心科技 on 17/3/18.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "CPMenuItem.h"

@implementation CPMenuItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

/// 根据状态变换字体的颜色
- (void)setSelected:(BOOL)selected
{
    if (self.selected == selected) return;
    
    _selected = selected;
    
    self.textColor = _selected ? self.selectedColor : self.normalColor;
    
}



- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    if (self.selected)
    {
        self.textColor = selectedColor;
    }
}

- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    if (!self.selected)
    {
        self.textColor = normalColor;
    }
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.selected) return;
    
    if ([self.delegate respondsToSelector:@selector(didClickMenuItem:)])
    {
        [self.delegate didClickMenuItem:self];
    }
}


@end
