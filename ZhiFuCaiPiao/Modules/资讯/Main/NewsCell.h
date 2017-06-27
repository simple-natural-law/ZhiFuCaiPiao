//
//  NewsCell.h
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/27.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
