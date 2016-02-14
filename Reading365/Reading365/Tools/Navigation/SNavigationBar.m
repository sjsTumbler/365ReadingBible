//
//  SNavigationBar.m
//  365_readingBible
//
//  Created by Sun jishuai on 15/7/21.
//  Copyright (c) 2015年 SunJishuai. All rights reserved.
//

#import "SNavigationBar.h"

@implementation SNavigationBar
#pragma  mark 基本导航栏初始化
/**
 @author SunJishuai , 15-07-21 23:07:53
 
 @brief  初始化
 
 @return
 */
- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, viewWidth, navigationBarHight);
        self.backgroundColor = iColorWithHex(navColor);
    }
    return self;
}
#pragma  mark 带标题导航栏初始化
/**
 @author SunJishuai, 15-07-21 23:07:53
 
 @brief  带标题导航栏初始化
 
 @param title 标题
 
 @return 
 */
-(id)initWithTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, viewWidth, navigationBarHight);
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:titleFontOfSize];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.frame = CGRectMake(85, 33, 150, 21);
        self.titleLabel.center = CGPointMake(viewWidth*0.5, self.titleLabel.center.y);
        self.titleLabel.text = title;
        
        self.backgroundColor = iColorWithHex(navColor);
        [self addSubview:self.titleLabel];
    }
    
    return self;
}
//设置标题
- (void)setTitle:(NSString *)title {
    if (self.titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:titleFontOfSize];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.frame = CGRectMake(85, 33, 150, 21);
        self.titleLabel.center = CGPointMake(viewWidth*0.5, self.titleLabel.center.y);
        [self addSubview:self.titleLabel];
    }
    self.titleLabel.text = title;
}
#pragma  mark 右侧文字按钮
/**
 @author SunJishuai , 15-07-21 23:07:37
 
 @brief  右侧文字按钮
 
 @param title
 */
-(void)setRightBtnTitle:(NSString *)title{
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(viewWidth-50, 33, 30, 21);
    self.rightBtn.tag = nav_right_tag;
    [self.rightBtn setTitle:title forState:UIControlStateNormal];
    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize: btnFontOfSize]];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightBtn];
}
#pragma  mark 右侧图片按钮
/**
 @author SunJishuai , 15-07-21 23:07:01
 
 @brief  右侧图片按钮
 
 @param imageName 图片名称
 */
-(void)setRightBtnImage:(NSString *)imageName
{
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(viewWidth-44, 30, 24, 24);
    self.rightBtn.tag = nav_right_tag;
    [self.rightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightBtn];
}
#pragma  mark  左侧文字按钮
/**
 @author SunJishuai , 15-07-21 23:07:03
 
 @brief  左侧文字按钮
 
 @param title
 */
-(void)setLeftBtnTitle:(NSString *)title
{
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(20, 33, 30, 21);
    self.leftBtn.tag = nav_left_tag;
    [self.leftBtn setTitle:title forState:UIControlStateNormal];
    [self.leftBtn.titleLabel setFont:[UIFont systemFontOfSize: btnFontOfSize]];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBtn];
}
#pragma  mark 左侧图片按钮
/**
 @author SunJishuai , 15-07-21 23:07:58
 
 @brief  左侧图片按钮
 
 @param imageName 图片名称
 */
-(void)setLeftBtnImage:(NSString *)imageName
{
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(20, 30, 24, 24);
    self.leftBtn.tag = nav_left_tag;
    [self.leftBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBtn];
}
#pragma  mark  “ < 返回 ”
/**
 @author SunJishuai , 15-08-04 19:08:44
 
 @brief  “ < 返回 ”
 */
-(void)setLeftBtn_bacK
{
    CGSize titleSize = [@"返回" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:btnFontOfSize]}];
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(20, 33, 15+titleSize.width, 21);
    self.leftBtn.tag = nav_left_tag;
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.leftBtn.titleLabel setFont:[UIFont systemFontOfSize: btnFontOfSize]];
    [self.leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBtn];
}
#pragma  mark 左侧按钮返回图片+上级标题创建
/**
 @author SunJishuai , 15-08-04 19:08:44
 
 @brief  左侧按钮返回图片+上级标题创建
 
 */
-(void)setLeftBtn_parentName:(NSString *)parentName
{
    CGSize titleSize = [parentName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:btnFontOfSize]}];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(15, 33, 15+titleSize.width, 21);
    self.leftBtn.tag = nav_left_tag;
    [self.leftBtn setTitle:[NSString stringWithFormat:@"%@",parentName] forState:UIControlStateNormal];
    [self.leftBtn.titleLabel setFont:[UIFont systemFontOfSize: btnFontOfSize]];
    [self.leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBtn];
}
//右侧按钮文字变更
- (void)editRightBtnTitle:(NSString *)title {
    [self.rightBtn setTitle:title forState:UIControlStateNormal];
}
//按钮的代理链接
-(void)leftBtnAction:(UIButton *)sender{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(SJSNavigationLeftAction:)]) {
        [_delegate SJSNavigationLeftAction:sender];
    }
}

-(void)rightBtnAction:(UIButton *)sender{
    if (_delegate != nil &&[_delegate respondsToSelector:@selector(SJSNavigationRightAction:)]) {
        [_delegate SJSNavigationRightAction:sender];
    }
}


@end
