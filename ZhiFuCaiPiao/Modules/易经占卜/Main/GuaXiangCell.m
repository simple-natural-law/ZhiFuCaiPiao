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

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 6.0;
 
    [super setFrame:frame];
}

- (void)setGuaXingWithInfo:(NSDictionary *)info row:(NSInteger)row
{
    switch (row)
    {
        case 0:
            self.textLabel.text = @"上爻";
            break;
        case 1:
            self.textLabel.text = @"五爻";
            break;
        case 2:
            self.textLabel.text = @"四爻";
            break;
        case 3:
            self.textLabel.text = @"三爻";
            break;
        case 4:
            self.textLabel.text = @"二爻";
            break;
        case 5:
            self.textLabel.text = @"初爻";
            break;
        default:
            break;
    }
}

@end
