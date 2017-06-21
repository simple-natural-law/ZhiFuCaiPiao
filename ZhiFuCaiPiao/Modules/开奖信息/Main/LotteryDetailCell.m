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





@implementation LotteryPrizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
