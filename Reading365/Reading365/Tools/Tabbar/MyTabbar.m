//
//  MyTabbar.m
//  自定义Tabbar
//
//  Created by Visitor on 14-8-19.
//  Copyright (c) 2014年 Visitor. All rights reserved.
//

#import "MyTabbar.h"

@implementation MyTabbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// 对类外接口函数
- (void)createMyTabbarWithTabbarInfo:(NSDictionary *)plistDict andClass:(id)classObject andSEL:(SEL)sel
{
    // 1.解析背景图的名字并创建背景ImageView
    NSString *imageName = [plistDict objectForKey:@"bgimage"];
    [self createBgImageViewWithImageName:imageName];
    // 2.解析每一个分栏中的内容并创建
    NSArray *items = [plistDict objectForKey:@"items"];
    for(int i=0;i<items.count;i++)
    {
        [self createItemWithItemDict:[items objectAtIndex:i] andIndex:i andCount:items.count andClass:classObject andSEL:sel];
    }
}

- (void)createBgImageViewWithImageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = self.bounds;
    [self addSubview:imageView];
}

- (void)createItemWithItemDict:(NSDictionary *)itemDict andIndex:(int)index andCount:(int)count andClass:(id)classObject andSEL:(SEL)sel
{
    // 1.实例化容器view
    UIView *baseView = [[UIView alloc] init];
    baseView.frame = CGRectMake(self.frame.size.width/count*index, 0, self.frame.size.width/count, self.frame.size.height);
    [self addSubview:baseView];
    
    // 2.实例化button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, baseView.frame.size.width, 40);
    UIImage *image = [UIImage imageNamed:[itemDict objectForKey:@"image"]];
    UIImage *image_press = [UIImage imageNamed:[itemDict objectForKey:@"image_press"]];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image_press forState:UIControlStateSelected];
    [btn addTarget:classObject action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.tag = index;
    [baseView addSubview:btn];
    
    // 3.实例化label
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 35, baseView.frame.size.width, baseView.frame.size.height-35);
    label.text = [itemDict objectForKey:@"title"];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.40f green:0.40f blue:0.40f alpha:1.00f];
    label.font = [UIFont systemFontOfSize:8];
    [baseView addSubview:label];

    // 设置默认项
    if(index == 0)
    {
        btn.selected = YES;
        label.textColor = [UIColor colorWithRed:0.00f green:0.66f blue:1.00f alpha:1.00f];
    }
}



















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
