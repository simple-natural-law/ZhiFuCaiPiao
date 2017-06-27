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
#define COLOR_RED         [UIColor colorWithRed:0.886 green:0.067 blue:0 alpha:1.0f]
#define COLOR_BLUE        [UIColor colorWithHexString:@"#4a89dc"]
#define COLOR_YELLOW      [UIColor colorWithRed:222.0/255.0 green:125.0/255.0 blue:44.0/255.0 alpha:1.0];
#define COLOR_GREEN       [UIColor colorWithRed:12.0/255.0 green:137.0/255.0 blue:24.0/255.0 alpha:1.0];
#define COLOR_BROWN       [UIColor colorWithRed:178.0/255.0 green:93.0/255.0 blue:37.0/255.0 alpha:1.0];
#define COLOR_DAILAN      [UIColor colorWithRed:66.0/255.0 green:80.0/255.0 blue:102.0/255.0 alpha:1.0];
#define COLOR_DAILV       [UIColor colorWithRed:66.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];

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
