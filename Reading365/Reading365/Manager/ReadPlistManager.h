//
//  ReadPlistManager.h
//  Reading365
//
//  Created by SunJishuai on 16/2/2.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefineManager.h"
#import "DataFactory.h"

@interface ReadPlistManager : NSObject
//单例化
+ (ReadPlistManager *)sharedReadPlistManager;
//初始化数据库
- (void)initHolyBibleData;
//从plist文件读取数组
- (NSArray *)readArrDataFromPlistFileAtPath:(NSString *)path Day:(NSInteger)day;
//  检查文件是否存在
- (BOOL)isFilePathExist:(NSString *)filePath isDir:(BOOL)isDir;
//  返回Document目录的路径
- (NSString *)DocumentsPath;
//从plist读取某天的数据
- (NSArray *)readArrayDataOnDay:(NSInteger)day;
//根据数据获取title
- (NSString *)getTitleByData:(NSArray *)dataArray Index:(NSInteger)index;

@end
