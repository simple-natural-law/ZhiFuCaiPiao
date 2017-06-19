//
//  CPHttpTaskInfo.h
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/19.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPHttpTaskInfo : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL callBack;

@property (nonatomic, strong) NSDictionary *parameters;

// 缓存数据,已经序列化好的本地对象
@property (nonatomic) id cacheData;

@end
