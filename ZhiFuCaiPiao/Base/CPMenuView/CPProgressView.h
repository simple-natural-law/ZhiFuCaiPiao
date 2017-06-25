//
//  GWCProgressView.h
//  GongWuChe_iOS_passenger
//
//  Created by 讯心科技 on 17/3/18.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPProgressView : UIView

/// 存放menuItem的frame的数组
@property (nonatomic, strong) NSArray *itemFrames;

/// 进度条的填充颜色
@property (nonatomic, assign) CGColorRef color;


@property (nonatomic, assign) CGFloat progress;


- (void)moveToPosition:(NSInteger)pos;


@end
