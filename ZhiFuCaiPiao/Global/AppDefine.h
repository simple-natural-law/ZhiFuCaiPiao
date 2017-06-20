//
//  AppDefine.h
//  ZhiFuCaiPiao
//
//  Created by 张诗健 on 2017/6/14.
//  Copyright © 2017年 张诗健. All rights reserved.
//

#ifndef AppDefine_h
#define AppDefine_h

// 颜色
#define COLOR_BACKGROUND  [UIColor colorWithHexString:@"#f4f4f4"] //背景色
#define RED               [UIColor colorWithRed:206/225.0 green:9/225.0 blue:26/225.0 alpha:1.0f]
#define COLOR_BLUE        [UIColor colorWithHexString:@"#2891F0"]

// 常量
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


// 宏构造代码
/*宏构造单例代码*/
#define LX_GTMOBJECT_SINGLETON_BOILERPLATE_WITH_SHARED(_object_name_, _obj_shared_name_) \
static _object_name_ *_##_object_name_ = nil; \
+ (instancetype)_obj_shared_name_ { \
if (!_##_object_name_) { \
@synchronized(self) { \
if (!_##_object_name_) { \
_##_object_name_ = [[[self class] alloc] init]; \
} \
} \
} \
return _##_object_name_; \
} \
+ (id)allocWithZone:(NSZone *)zone { \
@synchronized(self) { \
if (_##_object_name_ == nil) { \
_##_object_name_ = [super allocWithZone:zone]; \
return _##_object_name_; \
} \
} \
return nil; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return self; \
}

/*宏构造单例代码*/
#define LX_GTMOBJECT_SINGLETON_BOILERPLATE(_object_name_) LX_GTMOBJECT_SINGLETON_BOILERPLATE_WITH_SHARED(_object_name_, shared)



#endif /* AppDefine_h */
