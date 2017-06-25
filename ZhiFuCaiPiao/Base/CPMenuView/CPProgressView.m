//
//  GWCProgressView.m
//  GongWuChe_iOS_passenger
//
//  Created by 讯心科技 on 17/3/18.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "CPProgressView.h"


@interface CPProgressView ()
{
    int     sign;
    CGFloat gap;
    CGFloat step;
    
    __weak CADisplayLink *_link;
}


@end


@implementation CPProgressView

- (void)moveToPosition:(NSInteger)pos
{
    gap  = fabs(self.progress - pos);// 取绝对值
    sign = self.progress > pos ? -1 : 1;
    step = gap / 12.0;
    
    if (_link)
    {
        [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(progressChanged)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _link = link;
}

- (void)progressChanged
{
    if (gap > 0.000001)
    {
        gap -= step;
        
        if (gap < 0.0)
        {
            self.progress = (int)(self.progress + sign * step + 0.5);
            
            return;
        }
        
        self.progress += sign * step;
    }else
    {
        self.progress = (int)(self.progress + 0.5);
        
        [_link invalidate];
        
        _link = nil;
    }
}

- (void)setProgress:(CGFloat)progress
{
    if (self.progress == progress) return;
    
    _progress = progress;
    
    [self setNeedsDisplay]; // 重绘视图
}



- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    int index = (int)self.progress;
    
    index = (index <= self.itemFrames.count - 1) ? index : (int)self.itemFrames.count - 1;
    
    CGFloat rate = self.progress - index;
    
    CGRect currentFrame = [self.itemFrames[index] CGRectValue];
    
    CGFloat currentWidth = currentFrame.size.width;
    
    int nextIndex = index + 1 < self.itemFrames.count ? index + 1 : index;
    
    CGFloat nextWidth = [self.itemFrames[nextIndex] CGRectValue].size.width;
    
    CGFloat height    = self.frame.size.height;
    
    CGFloat constY    = height/2;
    
    CGFloat currentX  = currentFrame.origin.x;
    
    CGFloat nextX  = [self.itemFrames[nextIndex] CGRectValue].origin.x;
    
    CGFloat startX = currentX + (nextX - currentX)*rate;
    
    CGFloat endX   = startX + currentWidth + (nextWidth - currentWidth)*rate;
    
    CGContextMoveToPoint(ctx, startX, constY);
    
    CGContextAddLineToPoint(ctx, endX, constY);
    
    CGContextSetLineWidth(ctx, height);
    
    CGContextSetStrokeColorWithColor(ctx, self.color);
    
    CGContextStrokePath(ctx);

}

@end
