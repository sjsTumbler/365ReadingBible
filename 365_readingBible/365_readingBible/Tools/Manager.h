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
#define viewWidth 320.0
#define titleFontOfSize 20.0
#define btnFontOfSize 14.0


//按钮的Tag值
#define nav_right_tag 101
#define nav_left_tag 102

//颜色
#define navColor @"199fff"

#endif
