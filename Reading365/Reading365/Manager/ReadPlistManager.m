//
//  ReadPlistManager.m
//  Reading365
//
//  Created by SunJishuai on 16/2/2.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "ReadPlistManager.h"

@implementation ReadPlistManager
 #pragma mark    单例化
/**
 @author Jesus  , 16-02-02 16:02:12
 
 @brief 单例化
 
 @return 返回单例实体
 */
+ (ReadPlistManager *)sharedReadPlistManager {
    static ReadPlistManager *sharedReadPlistManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedReadPlistManagerInstance = [[self alloc] init];
    });
    return sharedReadPlistManagerInstance;
}
#pragma mark 初始化数据库
/**
 @author Jesus         , 16-02-02 20:02:58
 
 @brief 初始化数据库
 */
- (void)initHolyBibleData {
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
    
    //创建数据表
    [self buildTables];
}
 #pragma mark 创建数据表
/**
 @author Jesus      , 16-02-10 19:02:40
 
 @brief 创建数据表
 */
- (void)buildTables {
    [[DataFactory shardDataFactory]CreateDataBase];
    [[DataFactory shardDataFactory]CreateTable];
}
 #pragma mark  初始化阅读状态的plist文件
/**
 @author Jesus        , 16-02-17 09:02:17
 
 @brief 初始化阅读状态的plist文件
 */
- (void)initReadStatusPlist {
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isExist = [fm fileExistsAtPath:ReadStatusPlistPath];
    //如果不存在 isExist = NO，创建plist到Documents下
    if (!isExist)
    {
        NSMutableArray * nameArray = [[NSMutableArray alloc]init];
        for (int i = 1; i <= 365 ; i++) {
            [nameArray addObject:[NSString stringWithFormat:@"第%d天",i]];
        }
        
        NSMutableDictionary *refreshDic =[NSMutableDictionary dictionary];
        for(NSString *name in nameArray )
        {
            [refreshDic setValue:[NSNumber numberWithInt:0 ] forKey:name];
        }
        [refreshDic writeToFile:ReadStatusPlistPath atomically:YES];
    }
}
#pragma mark  从plist文件读取数组
/**
 @author Jesus   , 16-02-02 16:02:47
 
 @brief 从plist文件读取数组
 
 @param path 文件路径
 
 @return 返回读取到的数组
 */
- (NSArray *)readArrDataFromPlistFileAtPath:(NSString *)path Day:(NSInteger)day{
    if (![self isFilePathExist:path isDir:NO]) {
        return nil;
    } else {
        NSArray *plistArray = [[NSArray alloc] initWithContentsOfFile:path];
        return [plistArray objectAtIndex:day];
    }
}
 #pragma mark  检查文件是否存在
/**
 @author Jesus , 16-02-02 16:02:50
 
 @brief 检查文件是否存在
 
 @param filePath 文件路径
 @param isDir    是否是字典
 
 @return YES or NO
 */
- (BOOL)isFilePathExist:(NSString *)filePath isDir:(BOOL)isDir
{
    if (filePath) {
        NSString *path = [NSString stringWithString:filePath];
        if (!path || path.length <= 0) {
            return NO;
        }
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL dir;
        if ([fileManager fileExistsAtPath:path isDirectory:&dir]) {
            if (dir == isDir) {
                return YES;
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}
#pragma mark   返回Document目录的路径
/**
 @author Jesus       , 16-02-02 16:02:08
 
 @brief 返回Document目录的路径
 
 @return 路径
 */
- (NSString *)DocumentsPath;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
#pragma mark  从plist读取某天的数据
/**
 @author Jesus     , 16-02-02 17:02:19
 
 @brief 从plist读取某天的数据
 
 @param day 某天
 
 @return 对应的经文的数组
 */
- (NSArray *)readArrayDataOnDay:(NSInteger)day {
    NSString *path = [[NSBundle mainBundle]pathForResource:PlistName ofType:@"plist"];
    return  [self readArrDataFromPlistFileAtPath:path Day:day];
}
#pragma mark 根据数据获取title
/**
 @author Jesus         , 16-02-02 17:02:07
 
 @brief 根据数据获取title
 
 @param dataArray 数据数组
 @param index     数据定位
 
 @return 界面显示的标题
 */
- (NSString *)getTitleByData:(NSArray *)dataArray Index:(NSInteger)index {
    NSDictionary * dataDic = [dataArray objectAtIndex:index];
    return [dataDic objectForKey:@"title"];
}
#pragma mark  获取某段经文的阅读状态
/**
 @author Jesus         , 16-02-11 11:02:53
 
 @brief 获取某段经文的阅读状态
 
 @param tag
 
 @return 0 or 1
 */
- (NSString *)getStatusOfBible:(NSInteger)tag {
    __block NSString * statusStr = @"0";
    tag = tag + 1000000;
    NSMutableDictionary * search = [NSMutableDictionary dictionary];
    [search setValue:@(tag) forKey:@"onlyTag"];
    [[DataFactory shardDataFactory]searchWhere:search orderBy:nil offset:0 count:10 Classtype:status callback:^(NSArray *resultArray) {
        if (resultArray.count > 0) {
            StatusModel * model = [resultArray firstObject];
            statusStr = model.status;
        }
    }];
    return statusStr;
}
 #pragma mark  修改经文已读或未读
/**
 @author Jesus       , 16-02-10 22:02:54
 
 @brief 修改经文已读或未读
 
 @param tag    唯一字段
 @param isRead 状态
 */
- (void)setStatusOfBibleBy:(NSInteger)tag  isRead:(NSString *)isRead{
    NSString * onlyTag = [NSString stringWithFormat:@"%ld",tag+1000000];
    NSMutableDictionary * search = [NSMutableDictionary dictionary];
    [search setValue:onlyTag forKey:@"onlyTag"];
    [[DataFactory shardDataFactory]searchWhere:search orderBy:nil offset:0 count:10 Classtype:status callback:^(NSArray *resultArray) {
        if (resultArray.count > 0) {
            StatusModel * model = [resultArray firstObject];
            model.status = isRead;
            [[DataFactory shardDataFactory]updateToDB:model Classtype:status];
        }else {
            StatusModel * model = [[StatusModel alloc]init];
            model.onlyTag = onlyTag;
            model.status = isRead;
            model.version = 1;
            model.day = (int)tag/1000;
            model.part = (int)tag%1000;
            [[DataFactory shardDataFactory] insertToDB:model Classtype:status];
        }
    }];
    //修改阅读状态
    [self editDayStatusOfBible:(int)tag/1000];
}

#pragma mark  获取某天的读经状态
/**
 @author Jesus        , 16-02-11 08:02:02
 
 @brief 获取某天的读经状态
 
 @param day
 
 @return YES OR NO
 */
- (BOOL)getSatusOfBibleByDay:(int)day {
    __block BOOL isRead = NO;
    NSMutableDictionary * search = [NSMutableDictionary dictionary];
    [search setValue:@(day) forKey:@"day"];
    [search setValue:@(1) forKey:@"version"];
    [[DataFactory shardDataFactory]searchWhere:search orderBy:nil offset:0 count:10 Classtype:status callback:^(NSArray *resultArray) {
        if (resultArray.count == 4) {
            int readNumber = 0;
            for(StatusModel *model in resultArray){
                if ([model.status isEqualToString:@"1"]) {
                    readNumber++;
                }
            }
            if (readNumber == 4) {
                isRead = YES;
            }else {
                isRead = NO;
            }
        }else{
            isRead = NO;
        }
    }];
    return isRead;
}
#pragma mark  获取读经状态
/**
 @author Jesus        , 16-02-17 10:02:44
 
 @brief 获取读经状态
 
 @return 状态字典
 */
- (NSDictionary *)getSatusOfBible{
    return  [[NSDictionary alloc]initWithContentsOfFile:ReadStatusPlistPath];
}
 #pragma mark  修改某天的读经状态
/**
 @author Jesus       , 16-02-17 10:02:46
 
 @brief 修改某天的读经状态
 
 @param day 某天
 */
- (void)editDayStatusOfBible:(int)day {
     NSMutableDictionary * statusDic = [[NSMutableDictionary alloc]initWithDictionary:[self getSatusOfBible]];
    if([self getSatusOfBibleByDay:day]){//已读
        [statusDic setValue:[NSNumber numberWithInt:1] forKey:[NSString stringWithFormat:@"第%d天",day]];
    }else {//未读
    [statusDic setValue:[NSNumber numberWithInt:0] forKey:[NSString stringWithFormat:@"第%d天",day]];
    }
    [statusDic writeToFile:ReadStatusPlistPath atomically:YES];
//    [[NSNotificationCenter defaultCenter]postNotificationName:RefreshStatus object:nil];
}
@end
