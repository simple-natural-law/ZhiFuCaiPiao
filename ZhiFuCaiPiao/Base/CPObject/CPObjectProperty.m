//
//  CPObjectProperty.m
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/14.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#import "CPObjectProperty.h"
#import <objc/runtime.h>


/// class1 是否是 class2或其的子类
bool class_isClass( Class class1, Class class2 )
{
    if (class1==NULL || class2==NULL) { return NO; }
    
    if (class1 != class2) { return class_isClass( class_getSuperclass(class1), class2 ); }
    
    return true;
}

@implementation CPObjectProperty



@end



@implementation NSObject(propertyItems)

static const char* NSObject_propertyItems = "NSObject_propertyItems";
+ (NSArray *)propertyItems;
{
    // 缓存
    NSMutableDictionary * cacheItems = (id)objc_getAssociatedObject(self, NSObject_propertyItems);
    if (cacheItems == nil)
    {
        cacheItems = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, NSObject_propertyItems, cacheItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSArray * callBackData = [cacheItems objectForKey:NSStringFromClass(self)];
    if (callBackData == nil)
    {
        unsigned int outCount = 0;
        objc_property_t * properties = class_copyPropertyList([self class], &outCount);
        objc_property_t property = NULL;
        
        NSMutableArray * items = [NSMutableArray array];
        CPObjectProperty * item = nil;
        for (int i = 0; i < outCount; i++)
        {
            property = properties[i];
            item = [[CPObjectProperty alloc] init];
            item.propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            item.propertyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            [items addObject:item];
        }
        free(properties);
        
        callBackData = [NSArray arrayWithArray:items];
        [cacheItems setObject:callBackData forKey:NSStringFromClass(self)];
    }
    
    return callBackData;
}



@end
