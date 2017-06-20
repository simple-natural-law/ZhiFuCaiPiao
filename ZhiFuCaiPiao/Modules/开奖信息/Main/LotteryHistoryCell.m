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
        label.backgroundColor = COLOR_RED;
        label.layer.cornerRadius    = 15.0;
        label.layer.masksToBounds   = YES;
        label.layer.shouldRasterize = YES;
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
            label.backgroundColor = COLOR_BLUE;
            label.layer.cornerRadius    = 15.0;
            label.layer.masksToBounds   = YES;
            label.layer.shouldRasterize = YES;
        }
    }
}


//- (void)setLotteryInfo:(NSDictionary *)dic
//{
//    self.nameLabel.text   = dic[@"name"];
//    self.expectLabel.text = [NSString stringWithFormat:@"第%@期",dic[@"expect"]];
//    self.dateLabel.text   = dic[@"time"];
//    
//    NSArray *codeArray = [dic[@"openCode"] componentsSeparatedByString:@","];
//    
//    int offset = 0;
//    
//    for (int i = 0; i < codeArray.count; i++)
//    {
//        NSString *string = codeArray[i];
//        
//        if ([string containsString:@"+"])
//        {
//            NSArray *array = [string componentsSeparatedByString:@"+"];
//            
//            UILabel *label1 = [self.contentView viewWithTag:10086+i
//                              +offset];
//            label1.text     = string;
//            label1.backgroundColor     = [UIColor colorWithHexString:@"#37b761"];
//            label1.layer.cornerRadius  = 15.0;
//            label1.layer.masksToBounds = YES;
//            label1.text     = array[0];
//            label1.layer.shouldRasterize = YES;
//            
//            offset = 1;
//            
//            UILabel *label2 = [self.contentView viewWithTag:10086+i
//                              +offset];
//            label2.text     = string;
//            label2.backgroundColor     = [UIColor colorWithHexString:@"#37b761"];
//            label2.layer.cornerRadius  = 15.0;
//            label2.layer.masksToBounds = YES;
//            label2.text     = array[1];
//            label2.layer.shouldRasterize = YES;
//            
//        }else
//        {
//            UILabel *label = [self.contentView viewWithTag:10086+i+offset];
//            label.text     = string;
//            label.backgroundColor = COLOR_BLUE;
//            label.layer.cornerRadius    = 15.0;
//            label.layer.masksToBounds   = YES;
//            label.layer.shouldRasterize = YES;
//        }
//    }
//}

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
