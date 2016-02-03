//
//  AppDelegate.m
//  Reading365
//
//  Created by SunJishuai on 16/1/25.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "AppDelegate.h"
#import "STabbar.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
{
    UITabBarController  * _iTabBar;
    STabbar             * _sTabbar;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //初始化数据库
    [[ReadPlistManager sharedReadPlistManager]initHolyBibleData];
    
    _iTabBar = [[UITabBarController alloc]init];
    UINavigationController * readNav = [[UINavigationController alloc]initWithRootViewController:[[SJSReadingViewController alloc]init]];
    UINavigationController * setNav = [[UINavigationController alloc]initWithRootViewController:[[SJSSettingViewController alloc]init]];
    UINavigationController * collectionNav = [[UINavigationController alloc]initWithRootViewController:[[SJSCollectionViewController alloc]init]];
    UINavigationController * searchNav = [[UINavigationController alloc]initWithRootViewController:[[SJSSearchViewController alloc]init]];
    _iTabBar.viewControllers = [[NSArray alloc]initWithObjects:readNav,collectionNav,searchNav,setNav, nil];
    self.window.rootViewController = _iTabBar;
    
    _sTabbar = [[STabbar alloc]initWithClass:self Sel:@selector(itemClick:)];
    [self.window makeKeyAndVisible];
    
    [_iTabBar.view addSubview:_sTabbar];
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideTabbar) name:HideTabbar object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showTabbar) name:ShowTabbar object:nil];
    
    return YES;
}
 #pragma mark  tabbar 点击方法
/**
 @author Jesus , 16-01-25 21:01:55
 
 @brief tabbar 点击方法
 
 @param btn items
 */
- (void)itemClick:(UIButton *)btn
{
    // 1.让所有的按钮都变灰色
    NSArray *views = btn.superview.subviews;
    for(UIView *view in views)
    {
        ((UIButton *)view).selected = NO;
    }
    
    // 2.把当前按钮和label变成选中状态
    btn.selected = YES;
    
    // 3.让真实地tbc进行切换分栏
    _iTabBar.selectedIndex = btn.tag;
    
}
- (void)hideTabbar {
    _sTabbar.hidden = YES;
    _iTabBar.tabBar.hidden = YES;
    _iTabBar.hidesBottomBarWhenPushed = YES;
}
- (void)showTabbar {
    _sTabbar.hidden = NO;
    _iTabBar.tabBar.hidden = NO;
    _iTabBar.hidesBottomBarWhenPushed = NO;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
