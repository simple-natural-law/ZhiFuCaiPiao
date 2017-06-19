//
//  CPHttpResult.h
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/19.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPHttpResult : NSObject

// 请求是否成功
@property (nonatomic, readonly) NSInteger resultCode;

// 状态信息，如果 self.resultCode != 200, 提示用户
@property (nonatomic, readonly) NSString *message;

// 请求返回的资源
@property (nonatomic, readonly) id result;

// 结果是否是缓存数据
@property (nonatomic, readonly) BOOL isCache;

// 请求是否成功返回.(self.resultCode == 1)
@property (nonatomic, readonly) BOOL isSuccess;


/**
 *  创建网络资源对象
 *
 *  @param result  资源
 *  @param message 消息
 *  @param resultCode    请求是否成功(1-成功，其他失败)
 *  @param isCache 是否缓存
 *
 *  @return Object
 */
+ (instancetype)createWithResult:(id)result
                         message:(NSString *)message
                      resultCode:(NSInteger)resultCode
                         isCache:(BOOL)isCache;

@end
