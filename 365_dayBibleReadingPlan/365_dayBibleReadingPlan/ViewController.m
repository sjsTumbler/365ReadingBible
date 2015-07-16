//
//  ViewController.m
//  365_dayBibleReadingPlan
//
//  Created by Sun jishuai on 15/7/9.
//  Copyright (c) 2015年 SunJishuai. All rights reserved.
//

#import "ViewController.h"
#import "DataFactory.h"//数据库
#import "Manager.h"
#import "SandboxFile.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //读取数据库
    [self readHolyBible];
}
#pragma  mark 读取数据库
/**
 @author SunJishuai , 15-07-12 07:07:45
 
 @brief  读取数据库
 */
- (void)readHolyBible
{
   NSLog(@"找到数据库了 %@", [[NSBundle mainBundle]pathForResource:@"HolyBible" ofType:@"db"]);
    //从本地读取数据库
    if ([[DataFactory shardDataFactory]IsDataBase]) {
        NSLog(@"找到数据库了 ");
    }
    NSMutableDictionary * searchDic = [NSMutableDictionary dictionary];
    [searchDic setValue:@"太" forKey:@"Col001"];
    [[DataFactory shardDataFactory]searchWhere:searchDic orderBy:@"o_id" offset:0 count:10 Classtype:new_cuv callback:^(NSArray *resultArray) {
        NSLog(@"测试搜索结果输出 %lu",(unsigned long)resultArray.count);
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
