//
//  SNavigationBar.h
//  365_readingBible
//
//  Created by Sun jishuai on 15/7/21.
//  Copyright (c) 2015年 SunJishuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manager.h"

@protocol SJSNavigationDelegate <NSObject>
@optional
//左侧方法
-(void)SJSNavigationLeftAction:(UIButton *)sender;
//右侧按钮方法
-(void)SJSNavigationRightAction:(UIButton *)sender;
@end

@interface SNavigationBar : UIView


@property (nonatomic,strong) id<SJSNavigationDelegate> delegate;
//子控件
@property (nonatomic,strong) UILabel  *titleLabel;//标题
@property (nonatomic,strong) UIButton *rightBtn;//右侧按钮
@property (nonatomic,strong) UIButton *leftBtn;//左侧按钮

//初始化
- (id)init;
//标题初始化
-(id)initWithTitle:(NSString*)title;
//右侧按钮文字创建
-(void)setRightBtnTitle:(NSString *)title;
//右侧按钮图片创建
-(void)setRightBtnImage:(NSString *)imageName;
//左侧按钮文字创建
-(void)setLeftBtnTitle:(NSString *)title;
//左侧按钮图片创建
-(void)setLeftBtnImage:(NSString *)imageName;
//左侧按钮返回创建

//左侧按钮返回图片+上级标题创建



@end
