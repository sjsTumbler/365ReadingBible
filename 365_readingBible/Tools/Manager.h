//
//  Manager.h
//  365_dayBibleReadingPlan
//
//  Created by Sun jishuai on 15/7/12.
//  Copyright (c) 2015年 SunJishuai. All rights reserved.
//

#ifndef _65_dayBibleReadingPlan_Manager_h
#define _65_dayBibleReadingPlan_Manager_h

//测试NSLog输出设置 0-不输出  1-输出
#define MANAGER_DEBUG 1

#if !MANAGER_DEBUG
#define NSLog(...)
#endif

//尺寸
#define navigationBarHight 64.0
#define viewWidth [[UIScreen mainScreen] bounds].size.width
#define titleFontOfSize 20.0
#define btnFontOfSize 15.0


//按钮的Tag值
#define nav_right_tag 101
#define nav_left_tag 102



// 颜色
// 参数格式为：0xFFFFFF
#define iColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
// 参数格式为：222,222,222
#define iColorWithRGB(r, g, b) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:1.0f]

#define navColor 0x199fff

#endif
