//
//  GuaXiangCell.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/7/7.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "GuaXiangCell.h"

@interface GuaXiangCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detialLabel;
@property (weak, nonatomic) IBOutlet UILabel *identifierLabel;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@end


@implementation GuaXiangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.layer.cornerRadius  = 2.0;
    self.contentView.layer.masksToBounds = YES;
}


- (void)setGuaXingWithInfo:(NSArray *)info row:(NSInteger)row isShow:(BOOL)isShow
{
    switch (row)
    {
        case 0:
            self.titleLabel.text = @"上爻->";
            break;
        case 1:
            self.titleLabel.text = @"五爻->";
            break;
        case 2:
            self.titleLabel.text = @"四爻->";
            break;
        case 3:
            self.titleLabel.text = @"三爻->";
            break;
        case 4:
            self.titleLabel.text = @"二爻->";
            break;
        case 5:
            self.titleLabel.text = @"初爻->";
            break;
        default:
            break;
    }
    
    if (isShow)
    {
        self.leftView.hidden   = NO;
        self.rightView.hidden  = NO;
        self.centerView.hidden = [[info objectAtIndex:2] integerValue] == 0;
        
        // 0-反面 1-正面
        int value = [info[0] intValue] + [info[1] intValue] + [info[2] intValue];
        
        if (value == 0) // 3个背面-老阳
        {
            self.detialLabel.text = @"老阳";
            self.identifierLabel.text = @"○";
        }else if (value == 1)
        {
            self.detialLabel.text = @"少阴";
            self.identifierLabel.text = @"";
        }else if (value == 2)
        {
            self.detialLabel.text = @"少阳";
            self.identifierLabel.text = @"";
        }else
        {
            self.detialLabel.text = @"老阴";
            self.identifierLabel.text = @"X";
        }
    }
}

@end
