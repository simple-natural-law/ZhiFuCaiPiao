//
//  NSObject+extend.m
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "NSObject+extend.h"

@implementation NSObject (extend)

- (NSString *)JSONString
{
    return [[NSString alloc] initWithData:[self JSONData]  encoding:NSUTF8StringEncoding];
}

- (NSData *)JSONData {
    if (![NSJSONSerialization isValidJSONObject:self])
    {
        return nil;
    }
    return [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
}

- (id)objectFromJSON
{
    if ( [self isKindOfClass:[NSString class]] )
    {
        return [NSJSONSerialization JSONObjectWithData:[(NSString *)self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }
    
    return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
}


@end
