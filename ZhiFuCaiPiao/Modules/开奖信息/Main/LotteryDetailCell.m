//
//  LotteryDetailCell.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/21.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryDetailCell.h"


@interface LotteryDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *issuenoLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberBackgroundWidthCons;
@property (weak, nonatomic) IBOutlet UILabel *saleamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@end


@implementation LotteryDetailCell

- (void)setLotteryInfo:(NSDictionary *)dic name:(NSString *)name
{
    self.nameLabel.text    = name;
    self.issuenoLabel.text = [NSString stringWithFormat:@"第%@期",dic[@"issueno"]];
    
    NSString *dateStr      = dic[@"opendate"];
    if (dateStr.length > 10)
    {
        self.dateLabel.text   = dateStr;
    }else
    {
        self.dateLabel.text   = [NSString stringWithFormat:@"%@ (%@)",dateStr,[[NSDate dateWithString:dateStr withFormat:@"yyyy-MM-dd"] getWeekString]];
    }
    
    NSInteger totalmoney = [dic[@"totalmoney"] integerValue];
    if (totalmoney == 0)
    {
        self.totalMoneyLabel.text = @"正在统计";
    }else
    {
        self.totalMoneyLabel.text = [NSString stringWithFormat:@"%ld",totalmoney];
    }
    NSInteger saleamount = [dic[@"totalmoney"] integerValue];
    if (saleamount == 0)
    {
        self.saleamountLabel.text = @"正在统计";
    }else
    {
        self.saleamountLabel.text = [NSString stringWithFormat:@"%ld",saleamount];
    }
    
    NSArray *numberArray        = [dic[@"number"] componentsSeparatedByString:@" "];
    NSString *referNumberString = dic[@"refernumber"];
    NSInteger numberCount       = [numberArray count];
    NSArray *referNumberArr;
    NSInteger referNumberCount = 0;
    if (referNumberString.length > 0)
    {
        referNumberArr  = [referNumberString componentsSeparatedByString:@" "];
        referNumberCount  = [referNumberArr count];
    }
    
    NSInteger count     = numberCount+referNumberCount;
    CGFloat totalMargin = (count - 1) > 0 ? (count - 1)*5.0 : 0.0;
    self.numberBackgroundWidthCons.constant = count*30.0+totalMargin;
    [self.contentView layoutIfNeeded];
    
    for (int i = 0; i < numberArray.count; i++)
    {
        UILabel *label = [self.contentView viewWithTag:30000+i];
        label.text     = numberArray[i];
        label.backgroundColor = COLOR_RED;
        label.layer.cornerRadius    = 15.0;
        label.layer.masksToBounds   = YES;
        label.layer.shouldRasterize = YES;
    }
    
    for (int i = 0; i < referNumberCount; i++)
    {
        UILabel *label = [self.contentView viewWithTag:30000+i+numberCount];
        label.text     = referNumberArr[i];
        label.backgroundColor = COLOR_BLUE;
        label.layer.cornerRadius    = 15.0;
        label.layer.masksToBounds   = YES;
        label.layer.shouldRasterize = YES;
    }
}


@end





@implementation LotteryPrizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.fLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.sLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.fLabel.layer.borderWidth = 0.50f;
    self.sLabel.layer.borderWidth = 0.50f;
    self.tLabel.layer.borderWidth = 0.50f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
