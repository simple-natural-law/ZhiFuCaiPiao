//
//  CPObjectProperty.h
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/14.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <Foundation/Foundation.h>

/// class1 是否是 class2或其的子类
bool class_isClass( Class class1, Class class2 );

@interface CPObjectProperty : NSObject

@property (nonatomic, strong) NSString * propertyName;

@property (nonatomic, strong) NSString * propertyType;

@end


@interface NSObject (propertyItems)

+ (NSArray *)propertyItems;

@end
