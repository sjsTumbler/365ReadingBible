//
//  SHTabBarController.m
//  Reading365
//
//  Created by ccSunday on 16/2/27.
//  Copyright © 2016年 SunJishuai. All rights reserved.
//

#import "SHTabBarController.h"

#import "SHTabbar.h"

@implementation SHTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeController:) name:@"controllerChanged" object:nil];

    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
    [self setUpTabBar];
    
    // 设置子控制器
    [self setUpChildViewController];
    
    //去除 TabBar 自带的顶部阴影
    for (UIView *view in self.tabBar.subviews) {
        if ([view.superclass isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
}

/**
 *  利用 KVC 把 系统的 tabBar改为自定义类型。
 */

- (void)setUpTabBar{
    
    [self setValue:[[SHTabbar alloc] init] forKey:@"tabBar"];//tabBar
    
}

- (void)setUpChildViewController{
    // 1.读plist文件
    NSString *path = [NSString stringWithFormat:@"%@/STabbar.plist",[[NSBundle mainBundle] resourcePath]];
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *plistArr = plistDict[@"items"];
    
    // 2.添加子控制器
    for (NSDictionary *unitDit in plistArr) {
        //1、获取子控制器
        UIViewController *destinationVc = [(UIViewController *)[NSClassFromString(unitDit[@"controller"]) alloc] init];
        //2.封装一个导航控制器
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:destinationVc];
        //3.添加为子控制器
        [self addChildViewController:nav];
     
    }
    //3、tabbar赋值
    SHTabbar *tabbar = (SHTabbar *)self.tabBar;

    tabbar.dataArray = plistArr;
    
}

- (void)changeController:(NSNotification *)notification{
    UIButton *btn = (UIButton *)notification.object;
    self.selectedIndex = btn.tag;
}

@end
