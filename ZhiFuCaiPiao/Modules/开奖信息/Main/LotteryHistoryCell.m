//
//  LotteryHistoryCell.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/20.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryHistoryCell.h"

@interface LotteryHistoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *expectLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end


@implementation LotteryHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setLotteryInfo:(NSDictionary *)dic
{
    self.expectLabel.text = [NSString stringWithFormat:@"第%@期",dic[@"issueno"]];
    NSString *dateStr     = dic[@"opendate"];
    if (dateStr.length > 10)
    {
        self.dateLabel.text   = dateStr;
    }else
    {
        self.dateLabel.text   = [NSString stringWithFormat:@"%@ (%@)",dateStr,[[NSDate dateWithString:dateStr withFormat:@"yyyy-MM-dd"] getWeekString]];
    }
    
    NSArray *numberArray  = [dic[@"number"] componentsSeparatedByString:@" "];
    
    for (int i = 0; i < numberArray.count; i++)
    {
        UILabel *label = [self.contentView viewWithTag:10086+i];
        label.text     = numberArray[i];
        label.layer.backgroundColor = COLOR_RED.CGColor;
        label.layer.cornerRadius    = 15.0;
    }
    
    NSString *referNumberString = dic[@"refernumber"];
    
    if (referNumberString.length > 0)
    {
        NSInteger offset = numberArray.count;
        
        NSArray *referNumberArr = [referNumberString componentsSeparatedByString:@" "];
        
        for (int i = 0; i < referNumberArr.count; i++)
        {
            UILabel *label = [self.contentView viewWithTag:10086+i+offset];
            label.text     = referNumberArr[i];
            label.layer.backgroundColor = COLOR_BLUE.CGColor;
            label.layer.cornerRadius    = 15.0;
        }
    }
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.backgroundColor = highlighted ? [UIColor colorWithHexString:@"f0f0f0"] : [UIColor whiteColor];
    }];
}


- (void)setFrame:(CGRect)frame
{
    frame.origin.y    += 10;
    frame.size.height -= 10;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
