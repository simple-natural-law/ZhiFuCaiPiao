//
//  LotteryTrendView.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/23.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryTrendView.h"


//#define kItemWidth 24
//#define kLeftViewWidth 60

static CGFloat kItemWidth = 24.0;
static const CGFloat kLeftViewWidth = 60.0;

//期数
@interface NumberPeriodsView : UIView

@property (nonatomic, strong) NSArray *periodsArray;

- (instancetype)initWithFrame:(CGRect)frame periodsArray:(NSArray *)periodsArray;

@end

//中间内容
@interface NumberView : UIView

@property (nonatomic, strong) NSArray *numberArray;

@property (nonatomic, assign) LotteryTrendType type;

@property (nonatomic, assign) LotteryTrendStyle style;

@property (nonatomic, assign) NSInteger lastIndex;

- (instancetype)initWithFrame:(CGRect)frame type:(LotteryTrendType)type style:(LotteryTrendStyle)style numberArray:(NSArray *)numberArray;

@end

//上层数字
@interface TopNumberView : UIView

@property (nonatomic, assign) LotteryTrendType type;

@property (nonatomic, assign) NSInteger number;

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number type:(LotteryTrendType)type;

@end

//下面能选择的数字
@interface BottomNumberView : UIView

@property (nonatomic, assign) LotteryTrendType type;

@property (nonatomic, assign) NSInteger number;

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number type:(LotteryTrendType)type;

@end


//上和下悬浮的View
@interface TopBottomView : UIView
{
    BOOL hiddenFlag;
}

- (instancetype)initWithFrame:(CGRect)frame HiddenWrods:(BOOL)hidden;

@end


// 全部内容的容器
@interface LotteryTrendView ()<UIScrollViewDelegate,CAAnimationDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NumberPeriodsView *periodsView;
@property (nonatomic, strong) TopNumberView *topView;
@property (nonatomic, strong) BottomNumberView *bottomView;
@property (nonatomic, strong) NumberView *numView;
@property (nonatomic, assign) LotteryTrendType type;
@property (nonatomic, strong) TopBottomView *top;
@property (nonatomic, strong) TopBottomView *bottom;
@end


@implementation LotteryTrendView


- (instancetype)initWithFrame:(CGRect)frame type:(LotteryTrendType)type style:(LotteryTrendStyle)style dataArray:(NSArray *)dataArray
{
    if (self = [super initWithFrame:frame])
    {
        UIColor *backGroundColor = [UIColor colorWithRed:0.95 green:0.93 blue:0.87 alpha:1.0];
        
        self.backgroundColor = backGroundColor;
        self.type      = type;
        
        NSInteger numberCount = [[[dataArray firstObject] objectForKey:@"missNumber"] count];
        
        CGFloat contentWidth = numberCount*kItemWidth;
        
        if (contentWidth < frame.size.width - kLeftViewWidth)
        {
            contentWidth = frame.size.width - kLeftViewWidth;
            kItemWidth   = contentWidth/(CGFloat)numberCount;
        }
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kItemWidth, frame.size.width, frame.size.height-2*kItemWidth)];
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.backgroundColor = backGroundColor;
        
        CGSize contentSize    = CGSizeMake(contentWidth, kItemWidth*dataArray.count);
        self.scrollView.contentSize = CGSizeMake(contentSize.width+kLeftViewWidth, contentSize.height);
        [self addSubview:self.scrollView];
        
        //内容
        self.numView = [[NumberView alloc] initWithFrame:CGRectMake(kLeftViewWidth, 0, contentSize.width, contentSize.height) type:type style:style numberArray:dataArray];
        [self.scrollView addSubview:self.numView];

        self.topView     = [[TopNumberView alloc] initWithFrame:CGRectMake(kLeftViewWidth, 0, contentSize.width, kItemWidth) number:numberCount type:type];
        self.topView.backgroundColor = backGroundColor;
        [self addSubview:self.topView];
        
        NSMutableArray *periodsArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in dataArray)
        {
            if (type == LotteryTrendTypeSsq)
            {
                [periodsArray addObject:[dic[@"period"] substringFromIndex:4]];
            }else
            {
                [periodsArray addObject:dic[@"period"]];
            }
        }
        self.periodsView = [[NumberPeriodsView alloc] initWithFrame:CGRectMake(0, 0, kLeftViewWidth, contentSize.height) periodsArray:periodsArray];
        self.periodsView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:self.periodsView];
        
        self.bottomView  = [[BottomNumberView alloc] initWithFrame:CGRectMake(kLeftViewWidth, self.frame.size.height-kItemWidth, contentSize.width, kItemWidth) number:numberCount type:type];
        self.bottomView.backgroundColor = backGroundColor;
        [self addSubview:self.bottomView];
        
        self.top = [[TopBottomView alloc] initWithFrame:CGRectMake(0, 0, kLeftViewWidth, kItemWidth) HiddenWrods:YES];
        self.top.backgroundColor = backGroundColor;
        [self addSubview:self.top];
        self.bottom = [[TopBottomView alloc] initWithFrame:CGRectMake(0, frame.size.height-kItemWidth, kLeftViewWidth, kItemWidth) HiddenWrods:NO];
        self.bottom.backgroundColor = backGroundColor;
        [self addSubview:self.bottom];
    }
    return self;
}

- (void)displayWithType:(LotteryTrendType)type style:(LotteryTrendStyle)style dataArray:(NSArray *)dataArray
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type     = kCATransitionFade;
    transition.delegate = self;
    [self.layer addAnimation:transition forKey:@"transition"];
    
    NSInteger numberCount = [[[dataArray firstObject] objectForKey:@"missNumber"] count];
    
    CGFloat contentWidth = numberCount*kItemWidth;
    
    if (contentWidth < self.frame.size.width - kLeftViewWidth)
    {
        contentWidth = self.frame.size.width - kLeftViewWidth;
        kItemWidth   = contentWidth/(CGFloat)numberCount;
    }
    self.scrollView.frame = CGRectMake(0, kItemWidth, self.frame.size.width, self.frame.size.height-2*kItemWidth);
    CGSize contentSize    = CGSizeMake(contentWidth, kItemWidth*dataArray.count);
    self.scrollView.contentSize = CGSizeMake(contentSize.width+kLeftViewWidth, contentSize.height);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    [self.scrollView setNeedsDisplay];
    
    self.numView.frame = CGRectMake(kLeftViewWidth, 0, contentSize.width, contentSize.height);
    self.numView.numberArray = dataArray;
    self.numView.style = style;
    self.numView.type  = type;
    [self.numView setNeedsDisplay];
    
    self.topView.frame = CGRectMake(kLeftViewWidth, 0, contentSize.width, kItemWidth);
    self.topView.number = numberCount;
    self.topView.type   = type;
    [self.topView setNeedsDisplay];
    
    self.periodsView.frame = CGRectMake(0, 0, kLeftViewWidth, contentSize.height);
    if (self.type != type)
    {
        NSMutableArray *periodsArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in dataArray)
        {
            if (type == LotteryTrendTypeSsq)
            {
                [periodsArray addObject:[dic[@"period"] substringFromIndex:4]];
            }else
            {
                [periodsArray addObject:dic[@"period"]];
            }
        }
        self.periodsView.periodsArray = periodsArray;
    }
    [self.periodsView setNeedsDisplay];
    
    self.bottomView.frame = CGRectMake(kLeftViewWidth, self.frame.size.height-kItemWidth, contentSize.width, kItemWidth);
    self.bottomView.number = numberCount;
    [self.bottomView setNeedsDisplay];
    
    self.top.frame = CGRectMake(0, 0, kLeftViewWidth, kItemWidth);
    [self.top setNeedsDisplay];
    self.bottom.frame = CGRectMake(0, self.frame.size.height-kItemWidth, kLeftViewWidth, kItemWidth);
    [self.bottom setNeedsDisplay];
    
    self.type      = type;
}


//用 bounces 属性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ((scrollView.contentOffset.x <= 0))
    {
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
        
    }else if (scrollView.contentOffset.x + scrollView.frame.size.width >= scrollView.contentSize.width)
    {
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - scrollView.frame.size.width, scrollView.contentOffset.y);
    }
    
    self.periodsView.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x, 0);
    self.topView.transform = CGAffineTransformMakeTranslation(- scrollView.contentOffset.x, 0);
    self.bottomView.transform = CGAffineTransformMakeTranslation(- scrollView.contentOffset.x, 0);
}

@end


#pragma mark - NumberPeriodsView
@implementation NumberPeriodsView

- (instancetype)initWithFrame:(CGRect)frame periodsArray:(NSArray *)periodsArray
{
    if (self = [super initWithFrame:frame])
    {
        self.periodsArray = periodsArray;
    }
    return self;
}

//使用drawRect的创建方式相同内容速度是用时2.101958 ms 内存占用4.3M 速度是普通创建方式的25倍
- (void)drawRect:(CGRect)rect
{
    //获取上下文方法
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSInteger index = 0;
    for (NSString *periods in self.periodsArray)
    {
        index % 2 == 0 ? CGContextSetRGBFillColor(context, 0.95, 0.93, 0.87, 1) : CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1);
        CGContextFillRect(context, CGRectMake(0,index * kItemWidth,kLeftViewWidth,kItemWidth));
        
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.alignment = NSTextAlignmentCenter;
        //+4是因为文字的上下间距没有居中
        [[NSString stringWithFormat:@"%@期",periods] drawInRect:CGRectMake(0,kItemWidth/2.0-8 + index * kItemWidth,kLeftViewWidth,kItemWidth)
                                                withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1], NSParagraphStyleAttributeName : para}];
        index++;
    }
    NSInteger listCount = self.periodsArray.count;
    //画期数右侧线条
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 1);//线条颜色
    CGContextMoveToPoint(context, kLeftViewWidth - 1, 0);
    CGContextAddLineToPoint(context, kLeftViewWidth - 1, listCount * kItemWidth);
    //绘制线方法
    CGContextStrokePath(context);
}

@end

#pragma mark - NumberView
@implementation NumberView

- (instancetype)initWithFrame:(CGRect)frame type:(LotteryTrendType)type style:(LotteryTrendStyle)style numberArray:(NSArray *)numberArray
{
    if (self = [super initWithFrame:frame])
    {
        self.numberArray = numberArray;
        self.style = style;
        self.type  = type;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSInteger index = 0;
    //数字的个数
    NSInteger listCount = [[self.numberArray[index] objectForKey:@"missNumber"] count];
    for (NSDictionary *dic in self.numberArray)
    {
        //设置背景颜色
        index % 2 == 0 ? CGContextSetRGBFillColor(context, 0.95, 0.93, 0.87, 1) : CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1);
        CGContextFillRect(context, CGRectMake(0,index * kItemWidth,listCount*kItemWidth,kItemWidth));
        
        NSInteger numbIndex = 0;
        NSInteger selectIndex = 0;
        //绘制文字以及图片
        NSArray *numberArr  = [dic objectForKey:@"missNumber"];
        NSArray *awardArray = [dic objectForKey:@"winnerNumber"];
        
        for (int i = 0; i < numberArr.count; i++)
        {
            NSInteger num = 0;
            if (self.type == LotteryTrendTypeQxc)
            {
                num = numbIndex;
            }else
            {
                num = numbIndex + 1;
            }
            if (!(num == [awardArray[selectIndex] integerValue]))
            {
                NSString *numStr = nil;
                UIColor  *textColor = nil;
                if (self.style == LotteryTrendStyleQlc)
                {
                    if (num == [[awardArray lastObject] integerValue])
                    {
                        [COLOR_BLUE set];
                        CGContextFillEllipseInRect(context, CGRectMake(numbIndex * kItemWidth + 1,index * kItemWidth + 1, kItemWidth-2, kItemWidth-2));
                        numStr = [NSString stringWithFormat:@"%02ld",num];
                        textColor = [UIColor whiteColor];
                    }else
                    {
                        numStr = [NSString stringWithFormat:@"%02ld",[numberArr[i] integerValue]];
                        textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
                    }
                }else
                {
                    if (self.type == LotteryTrendTypeQxc)
                    {
                        numStr = [NSString stringWithFormat:@"%ld",[numberArr[i] integerValue]];
                    }else
                    {
                        numStr = [NSString stringWithFormat:@"%02ld",[numberArr[i] integerValue]];
                    }
                    textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
                }
                NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
                para.alignment = NSTextAlignmentCenter;
                //+4是因为文字的上下间距没有居中
                [numStr drawInRect:CGRectMake(numbIndex * kItemWidth,kItemWidth/2.0-8 + index * kItemWidth,kItemWidth,kItemWidth)
                               withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName : para}];
            }else
            {
                UIColor *color = [self colorWithStyle:self.style];
                // 绘制连线
                if (self.style == LotteryTrendStyleSsqBlue || self.type == LotteryTrendTypeQxc)
                {
                    CGContextSetStrokeColorWithColor(context, color.CGColor);
                    CGContextSetLineWidth(context, 1.0);
                    if (index > 0)
                    {
                        CGContextMoveToPoint(context, numbIndex*kItemWidth+kItemWidth/2.0, index*kItemWidth+kItemWidth/2.0);
                        
                        CGContextAddLineToPoint(context, self.lastIndex*kItemWidth+kItemWidth/2.0, (index-1)*kItemWidth+kItemWidth/2.0);
                        
                        CGContextStrokePath(context);
                    }
                    self.lastIndex = numbIndex;
                }
                
                [color set];
                
                CGContextFillEllipseInRect(context, CGRectMake(numbIndex * kItemWidth + 1,index * kItemWidth + 1, kItemWidth-2, kItemWidth-2));
                NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
                para.alignment = NSTextAlignmentCenter;
                NSString *numStr = nil;
                if (self.type == LotteryTrendTypeQxc)
                {
                    numStr = [NSString stringWithFormat:@"%ld",[awardArray[selectIndex] integerValue]];
                }else
                {
                    numStr = [NSString stringWithFormat:@"%02ld",[awardArray[selectIndex] integerValue]];
                }
                //+4是因为文字的上下间距没有居中
                [numStr drawInRect:CGRectMake(numbIndex * kItemWidth,kItemWidth/2.0-8 + index * kItemWidth,kItemWidth,kItemWidth)
                               withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor whiteColor], NSParagraphStyleAttributeName : para}];
                
                if (selectIndex < awardArray.count - 1)
                {
                    selectIndex++;
                }
            }
            numbIndex++;
        }
        index++;
    }
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 1);//线条颜色
    for (NSInteger i = 1; i <= listCount; i++)
    {
        //画期数竖着的线线条
        CGContextMoveToPoint(context, i * kItemWidth, 0);
        CGContextAddLineToPoint(context, i * kItemWidth, self.numberArray.count * kItemWidth);
    }
    CGContextStrokePath(context);
}

- (UIColor *)colorWithStyle:(LotteryTrendStyle)style
{
    switch (style)
    {
        case LotteryTrendStyleSsqRed:
            return COLOR_RED;
            break;
        case LotteryTrendStyleSsqBlue:
            return COLOR_BLUE;
            break;
        case LotteryTrendStyleDltInFront:
            return COLOR_RED;
            break;
        case LotteryTrendStyleDltBack:
            return COLOR_BLUE;
            break;
        case LotteryTrendStyleQlc:
            return COLOR_RED;
            break;
        case LotteryTrendStyleQxcOne:
            return COLOR_RED;
            break;
        case LotteryTrendStyleQxcTwo:
            return COLOR_BLUE;
            break;
        case LotteryTrendStyleQxcThree:
            return COLOR_YELLOW;
            break;
        case LotteryTrendStyleQxcFour:
            return COLOR_BROWN;
            break;
        case LotteryTrendStyleQxcFive:
            return COLOR_GREEN;
            break;
        case LotteryTrendStyleQxcSix:
            return COLOR_DAILAN;
            break;
        case LotteryTrendStyleQxcSeven:
            return COLOR_DAILV;
            break;
        default:
            return COLOR_RED;
            break;
    }
}


@end
#pragma mark - TopNumberView
@implementation TopNumberView

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number type:(LotteryTrendType)type
{
    if (self = [super initWithFrame:frame])
    {
        self.number = number;
        self.type = type;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //获取上下文方法
    CGContextRef context = UIGraphicsGetCurrentContext();
    //填充背景颜色
    CGContextSetRGBFillColor(context, 0.95, 0.93, 0.87, 1);
    CGContextFillRect(context, CGRectMake(0,0,self.number * kItemWidth,kItemWidth));
    
    //绘制数字
    for (NSInteger i = 1; i <= self.number ; i++)
    {
        NSString *numStr = nil;
        if (self.type == LotteryTrendTypeQxc)
        {
            numStr = [NSString stringWithFormat:@"%ld",i-1];
        }else
        {
            numStr = [NSString stringWithFormat:@"%02ld",i];
        }
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.alignment = NSTextAlignmentCenter;
        //+4是因为文字的上下间距没有居中
        [numStr drawInRect:CGRectMake((i-1) * kItemWidth,kItemWidth/2.0-8,kItemWidth,kItemWidth)
            withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1], NSParagraphStyleAttributeName : para}];
    }
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 1);//线条颜色
    for (NSInteger i = 1; i <= self.number; i++)
    {
        //画期数竖着的线线条
        CGContextMoveToPoint(context, i * kItemWidth, 0);
        CGContextAddLineToPoint(context, i * kItemWidth, kItemWidth);
    }
    //绘制线方法
    CGContextStrokePath(context);
}

@end

#pragma mark - BottomNumberView
@implementation BottomNumberView

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number type:(LotteryTrendType)type
{
    if (self = [super initWithFrame:frame])
    {
        self.number = number;
        self.type   = type;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //获取上下文方法
    CGContextRef context = UIGraphicsGetCurrentContext();
    //填充背景颜色
    CGContextSetRGBFillColor(context, 0.95, 0.93, 0.87, 1);
    CGContextFillRect(context, CGRectMake(0,0,self.number * kItemWidth,kItemWidth));
    
    //绘制数字
    for (NSInteger i = 1; i <= self.number ; i++)
    {
        NSString *numStr = nil;
        if (self.type == LotteryTrendTypeQxc)
        {
            numStr = [NSString stringWithFormat:@"%ld",i-1];
        }else
        {
            numStr = [NSString stringWithFormat:@"%02ld",i];
        }
        
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.alignment = NSTextAlignmentCenter;
        //+4是因为文字的上下间距没有居中
        [numStr drawInRect:CGRectMake((i-1) * kItemWidth,kItemWidth/2.0-8,kItemWidth,kItemWidth)
            withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1], NSParagraphStyleAttributeName : para}];
    }
    
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 1);//线条颜色
    for (NSInteger i = 1; i <= self.number; i++)
    {
        //画期数竖着的线线条
        CGContextMoveToPoint(context, i * kItemWidth, 0);
        CGContextAddLineToPoint(context, i * kItemWidth, kItemWidth);
    }
    //绘制线方法
    CGContextStrokePath(context);
}

@end

#pragma mark - TopBottomView
@implementation TopBottomView

- (instancetype)initWithFrame:(CGRect)frame HiddenWrods:(BOOL)hidden
{
    if (self = [super initWithFrame:frame])
    {
        hiddenFlag = hidden;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //获取上下文方法
    CGContextRef context = UIGraphicsGetCurrentContext();
    //绘制背景色
    CGContextSetRGBFillColor(context, 0.95, 0.93, 0.87, 1);
    CGContextFillRect(context, CGRectMake(0, 0, kLeftViewWidth, kItemWidth));
    
    if (!hiddenFlag)
    {
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.alignment = NSTextAlignmentCenter;
        //绘制下方文字
        //+4是因为文字的上下间距没有居中
        [@"选  号" drawInRect:CGRectMake(0, kItemWidth/2.0-8, kLeftViewWidth, kItemWidth)
             withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName : para}];
        //绘制方法
        CGContextStrokePath(context);
    }
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 1);//线条颜色
    CGContextMoveToPoint(context, kLeftViewWidth - 1.0, 0);
    CGContextAddLineToPoint(context, kLeftViewWidth - 1.0, kItemWidth);
    //绘制方法
    CGContextStrokePath(context);
}

@end

