//
//  LotteryTrendView.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/23.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryTrendView.h"


#define kItemWidth 24
#define kLeftViewWidth 60

//期数
@interface NumberPeriodsView : UIView

@property (nonatomic, strong) NSArray *periodsArray;

- (instancetype)initWithFrame:(CGRect)frame periodsArray:(NSArray *)periodsArray;

@end

//中间内容
@interface NumberView : UIView

@property (nonatomic, strong) NSArray *numberArray;

@end

//上层数字
@interface TopNumberView : UIView

@property (nonatomic, assign) NSInteger number;

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number;

@end

//下面能选择的数字
@interface BottomNumberView : UIView

@property (nonatomic, assign) NSInteger number;

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number;

@end


//上和下悬浮的View
@interface TopBottomView : UIView
{
    BOOL hiddenFlag;
}

- (instancetype)initWithFrame:(CGRect)frame HiddenWrods:(BOOL)hidden;

@end


// 全部内容的容器
@interface LotteryTrendView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NumberPeriodsView *periodsView;
@property (nonatomic, strong) TopNumberView *topView;
@property (nonatomic, strong) BottomNumberView *bottomView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) LotteryTrendType type;

@end


@implementation LotteryTrendView


- (instancetype)initWithFrame:(CGRect)frame type:(LotteryTrendType)type dataArray:(NSArray *)dataArray
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.type      = type;
        self.dataArray = dataArray;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kItemWidth, frame.size.width, self.frame.size.height-2*kItemWidth)];
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.backgroundColor = [UIColor lightGrayColor];
//        NSInteger numberCount = [[[dataArray firstObject] objectForKey:@"missNumber"] count];
        NSInteger numberCount = 33;
        CGSize contentSize    = CGSizeMake(numberCount*kItemWidth, kItemWidth*dataArray.count);
        self.scrollView.contentSize = CGSizeMake(contentSize.width+kLeftViewWidth, contentSize.height);
        [self addSubview:self.scrollView];
        
        
        self.topView     = [[TopNumberView alloc] initWithFrame:CGRectMake(kLeftViewWidth, 0, contentSize.width, kItemWidth) number:numberCount];
        self.topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topView];
        
        
        NSMutableArray *periodsArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in dataArray)
        {
            [periodsArray addObject:[dic[@"period"] substringFromIndex:4]];
        }
        self.periodsView = [[NumberPeriodsView alloc] initWithFrame:CGRectMake(0, 0, kLeftViewWidth, contentSize.height) periodsArray:periodsArray];
        self.periodsView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:self.periodsView];
        
        self.bottomView  = [[BottomNumberView alloc] initWithFrame:CGRectMake(kLeftViewWidth, self.frame.size.height-kItemWidth, contentSize.width, kItemWidth) number:numberCount];
        self.bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bottomView];
        
        TopBottomView *top = [[TopBottomView alloc] initWithFrame:CGRectMake(0, 0, kLeftViewWidth, kItemWidth) HiddenWrods:YES];
        top.backgroundColor = [UIColor whiteColor];
        [self addSubview:top];
        TopBottomView *bottom = [[TopBottomView alloc] initWithFrame:CGRectMake(0, frame.size.height-kItemWidth, kLeftViewWidth, kItemWidth) HiddenWrods:NO];
        bottom.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottom];
    }
    return self;
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
        index % 2 == 0 ? CGContextSetRGBFillColor(context, 0.87, 0.5, 0.87, 1) : CGContextSetRGBFillColor(context, 0.87, 0.87, 0.5, 1);
        CGContextFillRect(context, CGRectMake(0,index * kItemWidth,kLeftViewWidth,kItemWidth));
        
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.alignment = NSTextAlignmentCenter;
        //+4是因为文字的上下间距没有居中
        [[NSString stringWithFormat:@"%@期",periods] drawInRect:CGRectMake(0,4 + index * kItemWidth,kLeftViewWidth,kItemWidth)
                                                withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1], NSParagraphStyleAttributeName : para}];
        index++;
    }
    NSInteger listCount = self.periodsArray.count;
    //画期数右侧线条
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 1);//线条颜色
    CGContextMoveToPoint(context, kLeftViewWidth - 1, 0);
    CGContextAddLineToPoint(context, kLeftViewWidth - 1, listCount * kItemWidth);
    //绘制线方法
    CGContextStrokePath(context);
}

@end

#pragma mark - NumberView
@implementation NumberView


- (void)drawRect:(CGRect)rect
{
    if (self.numberArray.count > 0)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        NSInteger index = 0;
        //数字的个数
        NSInteger listCount = [[[self.numberArray[index] objectForKey:@"missNumber"] objectForKey:@"general"] count];
        for (NSDictionary *dic in self.numberArray)
        {
            //设置背景颜色
            index % 2 == 0 ? CGContextSetRGBFillColor(context, 0.87, 0.5, 0.87, 1) : CGContextSetRGBFillColor(context, 0.87, 0.87, 0.5, 1);
            CGContextFillRect(context, CGRectMake(0,index * kItemWidth,listCount * (kItemWidth + 1),kItemWidth));
            NSInteger numbIndex = 0;
            NSInteger selectIndex = 0;
            //绘制文字以及图片
            NSArray *numberArr = [[dic objectForKey:@"missNumber"] objectForKey:@"general"];
            NSArray *awardArray = [dic objectForKey:@"winnerNumber"];
            for (id num in numberArr)
            {
                
                if (!(numbIndex == [awardArray[selectIndex] integerValue]))
                {
                    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
                    para.alignment = NSTextAlignmentCenter;
                    //+4是因为文字的上下间距没有居中
                    [[num stringValue] drawInRect:CGRectMake(numbIndex * kItemWidth + 1 * numbIndex,4 + index * kItemWidth,kItemWidth,kItemWidth)
                                   withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1], NSParagraphStyleAttributeName : para}];
                }else
                {
                    [[UIColor colorWithRed:0.755 green:0.056 blue:0.081 alpha:1.000] set];
                    CGContextFillEllipseInRect(context, CGRectMake(numbIndex * kItemWidth + 1 * numbIndex,index * kItemWidth, kItemWidth, kItemWidth));
                    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
                    para.alignment = NSTextAlignmentCenter;
                    //+4是因为文字的上下间距没有居中
                    [[num stringValue] drawInRect:CGRectMake(numbIndex * kItemWidth + 1 * numbIndex,4 + index * kItemWidth,kItemWidth,kItemWidth)
                                   withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor whiteColor], NSParagraphStyleAttributeName : para}];
                    if (selectIndex < 4)
                    {
                        selectIndex++;
                    }
                }
                numbIndex++;
            }
            index++;
        }
        CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 1);//线条颜色
        for (NSInteger i = 0; i < listCount; i++)
        {
            //画期数竖着的线线条
            CGContextMoveToPoint(context,kItemWidth + i * kItemWidth + 1 * i, 0);
            CGContextAddLineToPoint(context,kItemWidth + i * kItemWidth + 1 * i, self.numberArray.count * kItemWidth);
        }
        CGContextStrokePath(context);
    }
}

@end
#pragma mark - TopNumberView
@implementation TopNumberView

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number
{
    if (self = [super initWithFrame:frame])
    {
        self.number = number;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //获取上下文方法
    CGContextRef context = UIGraphicsGetCurrentContext();
    //填充背景颜色
    CGContextSetRGBFillColor(context, 0.87, 0.87, 0.5, 1);
    CGContextFillRect(context, CGRectMake(0,0,self.number * kItemWidth,kItemWidth));
    
    //绘制数字
    for (NSInteger i = 1; i <= self.number ; i++)
    {
        NSString *numStr = [NSString stringWithFormat:@"%02ld",i];
        
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.alignment = NSTextAlignmentCenter;
        //+4是因为文字的上下间距没有居中
        [numStr drawInRect:CGRectMake((i-1) * kItemWidth,4,kItemWidth,kItemWidth)
            withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1], NSParagraphStyleAttributeName : para}];
    }
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

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number
{
    if (self = [super initWithFrame:frame])
    {
        self.number = number;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //获取上下文方法
    CGContextRef context = UIGraphicsGetCurrentContext();
    //填充背景颜色
    CGContextSetRGBFillColor(context, 0.87, 0.87, 0.5, 1);
    CGContextFillRect(context, CGRectMake(0,0,self.number * kItemWidth,kItemWidth));
    
    //绘制数字
    for (NSInteger i = 1; i <= self.number ; i++)
    {
        NSString *numStr = [NSString stringWithFormat:@"%02ld",i];
        
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.alignment = NSTextAlignmentCenter;
        //+4是因为文字的上下间距没有居中
        [numStr drawInRect:CGRectMake((i-1) * kItemWidth,4,kItemWidth,kItemWidth)
            withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1], NSParagraphStyleAttributeName : para}];
    }
    
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
    CGContextSetRGBFillColor(context, 0.87, 0.87, 0.5, 1);
    CGContextFillRect(context, CGRectMake(0, 0, kLeftViewWidth, kItemWidth));
    
    if (!hiddenFlag)
    {
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.alignment = NSTextAlignmentCenter;
        //绘制下方文字
        //+4是因为文字的上下间距没有居中
        [@"选  号" drawInRect:CGRectMake(0, 4, kLeftViewWidth, kItemWidth)
             withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName : para}];
        //绘制方法
        CGContextStrokePath(context);
        
    }
    //绘制上方和下方末尾的分割线
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 1);//线条颜色
    CGContextMoveToPoint(context, kLeftViewWidth - 1, 0);
    CGContextAddLineToPoint(context, kLeftViewWidth - 1, kItemWidth);
    //绘制方法
    CGContextStrokePath(context);
}

@end

