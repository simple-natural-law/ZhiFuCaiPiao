//
//  LineView.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/25.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (void)drawRect:(CGRect)rect
{
    CGContextRef contx = UIGraphicsGetCurrentContext();
    
    CGFloat pixelAdjustOffset = (1 / [UIScreen mainScreen].scale) / 2;
    
    CGContextSetLineWidth(contx, 1/[UIScreen mainScreen].scale);
    
    UIColor *color = [UIColor colorWithHexString:@"#cccccc"];
    
    CGContextSetStrokeColorWithColor(contx, self.lineColor? self.lineColor.CGColor : color.CGColor);
    
    if (self.bounds.size.width > self.bounds.size.height) {
        CGContextMoveToPoint(contx, CGRectGetMinX(rect), CGRectGetMidY(rect) - pixelAdjustOffset);
        CGContextAddLineToPoint(contx, CGRectGetMaxX(rect), CGRectGetMidY(rect) - pixelAdjustOffset);
    }else{
        CGContextMoveToPoint(contx, CGRectGetMidX(rect) - pixelAdjustOffset, CGRectGetMinY(rect));
        CGContextAddLineToPoint(contx, CGRectGetMidX(rect)- pixelAdjustOffset, CGRectGetMaxY(rect));
    }
    CGContextStrokePath(contx);
    
    [super drawRect:rect];
}

@end
