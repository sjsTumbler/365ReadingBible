//
//  STabbar.m
//  365_readingBible
//
//  Created by SunJishuai on 16/1/23.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "STabbar.h"

@implementation STabbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithClass:(id)classObject Sel:(SEL)sel
{
    self = [super initWithFrame:tabbarFrame];
    if (self) {
        // Initialization code
        // 1.创建背景
        self.backgroundColor = tabbarColor;
        // 2.读plist文件
        //@"%@/ 在当前工程的文件目录中读取文件
        NSString *path = [NSString stringWithFormat:@"%@/STabbar.plist",[[NSBundle mainBundle] resourcePath]];
        NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:path];
        // 3.解析每一个分栏中的内容并创建
        NSArray *items = [plistDict objectForKey:@"items"];
        for(int i=0;i<items.count;i++)
        {
            [self createItemWithItemDict:[items objectAtIndex:i] andIndex:i andCount:items.count andClass:classObject andSEL:sel];
        }
    }
    return self;
}


- (void)createItemWithItemDict:(NSDictionary *)itemDict andIndex:(int)index andCount:(NSInteger)count andClass:(id)classObject andSEL:(SEL)sel
{
   UIButton *item = [[PublicFunctions sharedPublicFunctions]imageAndLabelButtonByType:2 Label:[itemDict objectForKey:@"title"] LabelTextColor:[UIColor whiteColor] NormalImage:[itemDict objectForKey:@"image"] SelectedImage:nil Tag:index Frame:CGRectMake(viewWidth/count*index, 0, viewWidth/count, tabbarHeight)  FontSize:12];
    [item addTarget:classObject action:sel forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:item];
    // 设置默认项
    if(index == 0)
    {
        item.selected = YES;
    }
}

@end
