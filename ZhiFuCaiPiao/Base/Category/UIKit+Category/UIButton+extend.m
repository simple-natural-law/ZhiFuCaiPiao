//
//  UIButton+extend.m
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "UIButton+extend.h"

@implementation UIButton (extend)

- (NSString *)title
{
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}


+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target touchUpInsideAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGSize size = CGSizeZero;
    
    if (title.length)
    {
        UIFont *font = [UIFont systemFontOfSize:14.0];
        NSDictionary *dic = @{NSFontAttributeName : font};
        size = [title sizeWithAttributes:dic];
        size = CGSizeMake(size.width + 16, size.height + 16);
        button.titleLabel.font = font;
        button.title = title;
    }
    
    [button setFrame:CGRectMake(0, 0, size.width, size.height)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


+ (UIButton *)buttonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage target:(id)target touchUpInsideAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGSize size = CGSizeZero;
    
    if (normalImage)
    {
        size = CGSizeMake(normalImage.size.width, normalImage.size.height);
        [button setImage:normalImage forState:UIControlStateNormal];
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    [button setFrame:CGRectMake(0, 0, size.width, size.height)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


@end
