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
// 中奖号码
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;

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
    
    NSArray *codeArray = [dic[@"openCode"] componentsSeparatedByString:@","];
    
    for (int i = 0; i < codeArray.count; i++)
    {
        NSString *string = codeArray[i];
        
        if ([string containsString:@"+"])
        {
            
        }
    }
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
