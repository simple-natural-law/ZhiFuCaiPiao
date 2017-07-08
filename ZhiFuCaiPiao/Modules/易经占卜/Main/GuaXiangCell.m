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
            self.titleLabel.text = @"上爻";
            break;
        case 1:
            self.titleLabel.text = @"五爻";
            break;
        case 2:
            self.titleLabel.text = @"四爻";
            break;
        case 3:
            self.titleLabel.text = @"三爻";
            break;
        case 4:
            self.titleLabel.text = @"二爻";
            break;
        case 5:
            self.titleLabel.text = @"初爻";
            break;
        default:
            break;
    }
    
    if (isShow)
    {
        self.leftView.hidden   = NO;
        self.rightView.hidden  = NO;
        self.centerView.hidden = [[info objectAtIndex:2] integerValue] == 0;
    }
}

@end
