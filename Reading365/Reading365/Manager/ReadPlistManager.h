//
//  ReadPlistManager.h
//  Reading365
//
//  Created by SunJishuai on 16/2/2.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "DefineManager.h"
#import "DataFactory.h"
//#import "ModelHeader.h"
#import "DefineNotification.h"



@interface ReadPlistManager : NSObject
//单例化
+ (ReadPlistManager *)sharedReadPlistManager;
//初始化数据库
- (void)initHolyBibleData;
//初始化阅读状态的plist文件
- (void)initReadStatusPlist;
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
//获取读经状态
- (NSString *)getStatusOfBible:(NSInteger)tag;
//修改经文已读或未读
- (void)setStatusOfBibleBy:(NSInteger)tag isRead:(NSString *)isRead;//0 为未 1 为已读
//获取某天的读经状态
- (BOOL)getSatusOfBibleByDay:(int)day;
//获取读经状态
- (NSDictionary *)getSatusOfBible;

@end
