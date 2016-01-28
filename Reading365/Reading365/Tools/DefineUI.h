//
//  DefineUI.h
//  Reading365
//
//  Created by SunJishuai on 16/1/25.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#ifndef Reading365_DefineUI_h
#define Reading365_DefineUI_h

//测试NSLog输出设置 0-输出  1-不输出
#define MANAGER_DEBUG 0

#if MANAGER_DEBUG
#define NSLog(...)
#endif

//尺寸
#define navigationBarHight 64.0
#define viewWidth [[UIScreen mainScreen] bounds].size.width
#define viewHeight [[UIScreen mainScreen] bounds].size.height
#define titleFontOfSize 20.0
#define btnFontOfSize 15.0
#define tabbarHeight  49.0

//按钮的Tag值
#define nav_right_tag 101
#define nav_left_tag  102



// 颜色
// 参数格式为：0xFFFFFF
#define iColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
// 参数格式为：222,222,222
#define iColorWithRGB(r, g, b) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:1.0f]

#define navColor 0x199fff


#define tabbarColor iColorWithRGB(5, 178, 215)
#define tabbarFrame CGRectMake(0, viewHeight-tabbarHeight, viewWidth, tabbarHeight)
#define tabbarSelectTextColor iColorWithHex(0xcccccc)

#endif