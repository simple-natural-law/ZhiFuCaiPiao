//
//  CPHttpResult.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/19.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "CPHttpResult.h"

@implementation CPHttpResult

- (BOOL)isSuccess
{
    return (self.resultCode == 200);
}


+ (instancetype)createWithResult:(id)result
                         message:(NSString *)message
                      resultCode:(NSInteger)resultCode
                         isCache:(BOOL)isCache {
    CPHttpResult * info = [[self.class alloc] init];
    info->_result = result;
    info->_isCache = isCache;
    info->_resultCode = resultCode;
    info->_message = message;
    return info;
}


@end
