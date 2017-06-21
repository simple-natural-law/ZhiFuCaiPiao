//
//  LotteryDetailCell.h
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/21.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LotteryDetailCell : UITableViewCell

- (void)setLotteryInfo:(NSDictionary *)dic name:(NSString *)name;

@end



@interface LotteryPrizeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fLabel;
@property (weak, nonatomic) IBOutlet UILabel *sLabel;
@property (weak, nonatomic) IBOutlet UILabel *tLabel;

@end
