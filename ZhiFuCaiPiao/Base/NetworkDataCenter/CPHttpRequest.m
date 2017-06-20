//
//  CPHttpRequest.m
//  ZhiFuCaiPiao
//
//  Created by 讯心科技 on 2017/6/19.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "CPHttpRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "CPHttpTaskInfo.h"


@interface CPHttpRequest ()

@property (nonatomic, strong, readwrite) AFHTTPSessionManager *manager;

// 记录请求任务
@property (nonatomic, strong) NSMutableArray *taskItems;

// 网络状态
@property (nonatomic, assign) AFNetworkReachabilityStatus networkStatus;

@end


@implementation CPHttpRequest

LX_GTMOBJECT_SINGLETON_BOILERPLATE_WITH_SHARED(CPHttpRequest, shared)


- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.manager = [[AFHTTPSessionManager alloc]init];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        self.taskItems = [NSMutableArray array];
        self.networkStatus = AFNetworkReachabilityStatusUnknown;
        
        NSOperationQueue *operationQueue = self.manager.operationQueue;
        
        __block CPHttpRequest *weakself = self;
        
        // 监听网络状态
        [self.manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    
                    [operationQueue setSuspended:NO];
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    
                    [operationQueue setSuspended:NO];
                    
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable: // 无网络
                    
                    // 暂停
                    [operationQueue setSuspended:YES];
                    
                    break;
                    
                default:
                    break;
            }
            weakself.networkStatus = status;
        }];
        
        // 开始监听
        [self.manager.reachabilityManager startMonitoring];
    }
    return self;
}

+ (void)POST:(NSString *)path parameters:(NSDictionary *)parameters target:(id)target callBack:(SEL)callBack
{
    NSURLSessionDataTask *dataTask = nil;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [CPHttpRequest shared].manager;
    
    dataTask = [manager POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        [[CPHttpRequest shared] requestDataTask:task responseObject:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        for (NSInteger i = (NSInteger)[CPHttpRequest shared].taskItems.count-1; i >= 0; i--)
        {
            CPHttpTaskInfo *taskInfo = [CPHttpRequest shared].taskItems[i];
            
            if (taskInfo.dataTask == task)
            {
                taskInfo.dataTask = nil;
                [[CPHttpRequest shared].taskItems removeObject:taskInfo];
                [[CPHttpRequest shared] callBackTask:taskInfo result:nil];
                break;
            }
        }
#ifdef DEBUG_MODE
        NSLog(@"NetworkError->%@",error.userInfo);
#endif
    }];
    
    
    // 记录请求任务
    CPHttpTaskInfo *taskInfo = [[CPHttpTaskInfo alloc] init];
    taskInfo.target   = target;
    taskInfo.callBack = callBack;
    taskInfo.dataTask = dataTask;
    taskInfo.parameters  = parameters;
    
    [[[CPHttpRequest shared] taskItems] addObject:taskInfo];
}

- (void)requestDataTask:(NSURLSessionDataTask *)dataTask responseObject:(id)responseObject
{
    CPHttpTaskInfo *taskInfo = nil;
    
    for (CPHttpTaskInfo *t in self.taskItems)
    {
        if (t.dataTask == dataTask)
        {
            taskInfo = t;
            break;
        }
    }
    
    if (taskInfo == nil)
    {
#if DEBUG_NETWORK_LOG
        NSLog(@"\r\n*******已经从请求队列删除 : %@\r\n",taskInfo.dataTask.currentRequest.URL.path);
#endif
        return;
    }
    
    if (dataTask.state == NSURLSessionTaskStateCompleted)
    {
        // 回调
        [self callBackTask:taskInfo result:responseObject];
    }
    
    // 清除已经完成的任务
    taskInfo.dataTask = nil;
    [self.taskItems removeObject:taskInfo];
}


- (void)callBackTask:(CPHttpTaskInfo *)taskInfo result:(id)result
{
    [self callBackTarget:taskInfo.target selector:taskInfo.callBack result:result];
}


- (void)callBackTarget:(id)target selector:(SEL)selector result:(id)result
{
    if (!target) return;
    
    NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
    
    if (methodSignature == nil)
    {
        methodSignature = [[target class] instanceMethodSignatureForSelector:selector];
    }
    
    if (methodSignature == nil) return;
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    
    [invocation setTarget:target];
    
    [invocation setSelector:selector];
    
    [invocation setArgument:&result atIndex:2];
    
    [invocation invoke];
}


+ (void)cancelRequestWithTarget:(id)target
{
    NSMutableArray *items = [CPHttpRequest shared].taskItems;
    
    for (int i = 0; i < items.count; i++)
    {
        CPHttpTaskInfo *taskInfo = items[i];
        
        if (taskInfo.target == target)
        {
            [taskInfo.dataTask cancel];
#if DEBUG_NETWORK_LOG
            if (taskInfo.dataTask.state != NSURLSessionTaskStateCanceling)
            {
                NSLog(@"\r\n*******任务取消失败: %@\r\n",taskInfo.dataTask.currentRequest.URL.path);
            }
#endif
            taskInfo.dataTask = nil;
            
            [items removeObject:taskInfo];
            
            i--;
        }
    }
}

/**
 *  清除所有请求，除了当前请求
 *
 *  @param dataTask 当前请求的dataTask
 */

+ (void)cancleAllRequestWithOutDataTask:(NSURLSessionDataTask *)dataTask
{
    NSMutableArray *items = [CPHttpRequest shared].taskItems;
    
    for (int i = 0; i<items.count; i++)
    {
        CPHttpTaskInfo *task = items[i];
        
        if (task.dataTask != dataTask)
        {
            [task.dataTask cancel];
            [items removeObject:task];
            i--;
        }
    }
}

/**
 *  网络是否通畅
 */
+ (BOOL)isNetworkGood
{
    return [CPHttpRequest shared].networkStatus != AFNetworkReachabilityStatusNotReachable;
}

@end
