//
//  LotteryDetailCell.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/21.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryDetailCell.h"

@implementation LotteryDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateUIWithLotteryInfo:(NSDictionary *)info row:(NSInteger)row
{
    switch (row) {
        case 1:
        {
            self.iconImageView.image = [UIImage imageNamed:@"opennumber"];
            self.titleLabel.text     = @"开奖号码:";
            self.contentLabel.text   = info[@"number"];
            self.backgroundColor     = [UIColor whiteColor];
        }
            break;
        case 2:
        {
            self.iconImageView.image = [UIImage imageNamed:@"opendate"];
            self.titleLabel.text     = @"开奖日期:";
            self.contentLabel.text   = info[@"opendate"];
            self.backgroundColor     = [UIColor colorWithRed:214/225.0 green:215/225.0 blue:216/225.0 alpha:1.0];
        }
            break;
        case 3:
        {
            self.iconImageView.image = [UIImage imageNamed:@"saleamount"];
            self.titleLabel.text     = @"本期销量:";
            self.contentLabel.text   = info[@"saleamount"];
            self.backgroundColor     = [UIColor whiteColor];
        }
            break;
        case 4:
        {
            self.iconImageView.image = [UIImage imageNamed:@"prize"];
            self.titleLabel.text     = @"奖池奖金:";
            self.contentLabel.text   = [NSString stringWithFormat:@"¥%@",info[@"totalmoney"]];
            self.backgroundColor     = [UIColor colorWithRed:214/225.0 green:215/225.0 blue:216/225.0 alpha:1.0];
        }
            break;
        default:
            break;
    }
}

@end


@interface LotteryDetailInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *issuenoLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberBackgroundWidthCons;
@property (weak, nonatomic) IBOutlet UILabel *saleamountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@end


@implementation LotteryDetailInfoCell

- (void)setLotteryInfo:(NSDictionary *)dic
{
    self.issuenoLabel.text = [NSString stringWithFormat:@"第%@期",dic[@"issueno"]];
    NSString *dateStr      = dic[@"opendate"];
    if (dateStr.length > 10)
    {
        self.dateLabel.text   = dateStr;
    }else
    {
        self.dateLabel.text   = [NSString stringWithFormat:@"%@ (%@)",dateStr,[[NSDate dateWithString:dateStr withFormat:@"yyyy-MM-dd"] getWeekString]];
    }
    
    NSArray *numberArray        = [dic[@"number"] componentsSeparatedByString:@" "];
    NSString *referNumberString = dic[@"refernumber"];
    NSInteger numberCount       = [numberArray count];
    NSArray *referNumberArr     = [referNumberString componentsSeparatedByString:@" "];
    NSInteger referNumberCount  = [referNumberArr count];
    
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
    
    if (referNumberString.length > 0)
    {
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
