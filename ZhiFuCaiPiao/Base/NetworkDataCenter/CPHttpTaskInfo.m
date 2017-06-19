//
//  CPHttpTaskInfo.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/19.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "CPHttpTaskInfo.h"

static NSCache * _cache = nil;

@implementation CPHttpTaskInfo

@synthesize target = _target;

- (id)target {
    return _target;
}
- (void)setTarget:(id)target {
    _target = target;
}




- (id)cacheData {
    
    NSString * key = [self.dataTask.currentRequest.URL.relativeString stringByAppendingString:@"?"];
    int i = 0;
    for (NSString * k in self.parameters.allKeys) {
        NSString * v = [self.parameters objectForKey:k];
        key = [key stringByAppendingString:[NSString stringWithFormat:@"%@%@=%@", (i==0?@"":@"&"), k, v]];
        i++;
    }
    
    if (key.length == 0) {
        return nil;
    }
    
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
    }
    
    return [_cache objectForKey:key];
    
}

- (void)setCacheData:(id)cacheData {
    
    NSString * key = [self.dataTask.currentRequest.URL.relativeString stringByAppendingString:@"?"];
    int i = 0;
    for (NSString * k in self.parameters.allKeys) {
        NSString * v = [self.parameters objectForKey:k];
        key = [key stringByAppendingString:[NSString stringWithFormat:@"%@%@=%@", (i==0?@"":@"&"), k, v]];
        i++;
    }
    
    if (key.length == 0) {
        return;
    }
    
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
    }
    
    if (cacheData == nil) {
        [_cache removeObjectForKey:key];
    } else {
        [_cache setObject:cacheData forKey:key];
    }
}


@end
