//
//  LotteryHistoryCell.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/20.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "LotteryHistoryCell.h"

@interface LotteryHistoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
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
    self.nameLabel.text   = dic[@"name"];
    self.expectLabel.text = [NSString stringWithFormat:@"第%@期",dic[@"expect"]];
    self.dateLabel.text   = dic[@"time"];
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
