//
//  CPHttpRequest.h
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/19.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPHttpRequest : NSObject

+ (void)POST:(NSString *)path
  parameters:(NSDictionary *)parameters
      target:(id)target
    callBack:(SEL)callBack;

+ (void)GET:(NSString *)path
 parameters:(NSDictionary *)parameters
authorization:(NSString *)authorization
     target:(id)target
   callBack:(SEL)callBack;


+ (void)cancelRequestWithTarget:(id)target;

@end
