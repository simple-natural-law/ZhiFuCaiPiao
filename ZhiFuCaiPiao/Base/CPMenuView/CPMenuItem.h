//
//  GWCMenuItem.h
//  GongWuChe_iOS_passenger
//
//  Created by 讯心科技 on 17/3/18.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CPMenuItem;

typedef NS_ENUM(NSInteger,CPMenuItemState) {
    CPMenuItemStateNormal,
    CPMenuItemStateSelected
};


@protocol CPMenuItemDelegate <NSObject>

@optional
- (void)didClickMenuItem:(CPMenuItem *)item;

@end


@interface CPMenuItem : UILabel

@property (nonatomic,strong) UIColor *normalColor;

@property (nonatomic,strong) UIColor *selectedColor;

@property (nonatomic, weak) id<CPMenuItemDelegate> delegate;

@property (nonatomic,assign) BOOL selected;

@end
