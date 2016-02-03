//
//  RootViewController.h
//  365_readingBible
//
//  Created by SunJishuai on 16/1/23.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//
// 适配
#import <UIKit/UIKit.h>
#import "SNavigationBar.h"
#import "NoticeHeader.h"
#import "ReadPlistManager.h"

@interface RootViewController : UIViewController<SJSNavigationDelegate>
@property (nonatomic,strong) SNavigationBar * SNavigationBar;
@end
