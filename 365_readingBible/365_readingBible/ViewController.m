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

#define DATABASE_FILE_NAME @"HolyBible.db"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //读取数据库
    [self readHolyBible];
    
    NSMutableDictionary * searchDic = [NSMutableDictionary dictionary];
    [searchDic setValue:@"太" forKey:@"Col001"];
    //[searchDic setValue:@"201001001" forKey:@"o_id"];
    [[DataFactory shardDataFactory]searchWhere:searchDic orderBy:nil offset:0 count:10 Classtype:new_cuv callback:^(NSArray *resultArray) {
        NSLog(@"测试搜索结果输出 %lu",(unsigned long)resultArray.count);
    }];
}
#pragma  mark 读取数据库
/**
 @author SunJishuai , 15-07-12 07:07:45
 
 @brief  读取数据库
 */
- (void)readHolyBible
{
    //获取应用程序的路径
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(
                                                               NSDocumentDirectory,
                                                               NSUserDomainMask,
                                                               YES);
    NSString *documentFolderPath = [searchPaths objectAtIndex:0];
    NSLog(@"docoumentFolderPath=%@",documentFolderPath);
    //往应用程序路径中添加数据库文件名称
    NSString *  dbFilePath = [documentFolderPath stringByAppendingPathComponent:DATABASE_FILE_NAME];
    NSLog(@"dbFilePath = %@",dbFilePath);
    //根据上面拼接好的路径 dbFilePath ，利用NSFileManager 类的对象的fileExistsAtPath方法来检测是否存在，返回一个BOOL值
    //1. 创建NSFileManager对象  NSFileManager包含了文件属性的方法
    NSFileManager *fm = [NSFileManager defaultManager];
    //2. 通过 NSFileManager 对象 fm 来判断文件是否存在，存在 返回YES  不存在返回NO
    BOOL isExist = [fm fileExistsAtPath:dbFilePath];
    //如果不存在 isExist = NO，拷贝工程里的数据库到Documents下
    if (!isExist)
    {
        //拷贝数据库
        //获取工程里，数据库的路径,因为我们已在工程中添加了数据库文件，所以我们要从工程里获取路径
        NSString *backupDbPath = [[NSBundle mainBundle]
                                  pathForResource:@"HolyBible"
                                  ofType:@"db"];
        //这一步实现数据库的添加，
        // 通过NSFileManager 对象的复制属性，把工程中数据库的路径拼接到应用程序的路径上
        BOOL cp = [fm copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
        NSLog(@"cp = %d",cp);
        NSLog(@"backupDbPath =%@",backupDbPath);
        
    }
    NSLog(@"isExist =%d",isExist);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
