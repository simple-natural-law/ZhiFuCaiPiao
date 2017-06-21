//
//  LotteryDetailCell.h
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/21.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)updateUIWithLotteryInfo:(NSDictionary *)info row:(NSInteger)row;

@end



@interface LotteryPrizeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fLabel;
@property (weak, nonatomic) IBOutlet UILabel *sLabel;
@property (weak, nonatomic) IBOutlet UILabel *tLabel;

@end
