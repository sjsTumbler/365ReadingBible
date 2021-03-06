//
//  DataFactory.h
//
//
//  Created by mac  on 12-12-7.
//  Copyright (c) 2012年 sky. All rights reserved.
//  这个我是在原来的几个项目当做一个数据库处理工厂

#import <Foundation/Foundation.h>
#import "SandboxFile.h"
#import "FMDatabaseQueue.h"


#define GetDataBasePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]stringByAppendingPathComponent:@"HolyBible.db"]
//[[NSBundle mainBundle]pathForResource:@"HolyBible" ofType:@"db"]
//[SandboxFile GetPathForDocuments:@"HolyBible.sqlite3" inDir:@"DataBase"]

@interface DataFactory : NSObject
@property(retain,nonatomic)id classValues;
typedef enum
{
    old_cuv,//和合本旧约
    old_ncv,//新译本旧约
    old_niv,//英文版旧约
    new_cuv,//和合本新约
    new_ncv,//新译本新约
    new_niv,//英文版新约
    
    status,//经文状态
    indexing,//目录索引
    collection,//收藏
}
FSO;//这个是枚举是区别不同的实体
+(DataFactory *)shardDataFactory;
//是否存在数据库
-(BOOL)IsDataBase;
//创建数据库
-(void)CreateDataBase;
//创建表
-(void)CreateTable;
//添加数据
-(void)insertToDB:(id)Model Classtype:(FSO)type;
//修改数据
-(void)updateToDB:(id)Model Classtype:(FSO)type;
//删除单条数据
-(void)deleteToDB:(id)Model Classtype:(FSO)type;
//删除表的数据
-(void)clearTableData:(FSO)type;
//根据条件删除数据
-(void)deleteWhereData:(NSDictionary *)Model Classtype:(FSO)type;
//查找数据
-(void)searchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(void(^)(NSArray *))result;

#warning 后面七个方法明天再写
//添加数据
-(BOOL)syncInsertToDB:(id)Model Classtype:(FSO)type;

//修改数据
-(BOOL)syncUpdateToDB:(id)Model Classtype:(FSO)type;
//批量修改数据
-(void)syncBatchUpdateToDB:(NSArray *)dataArray Classtype:(FSO)type;

//删除单条数据
-(BOOL)syncDeleteToDB:(id)Model Classtype:(FSO)type;

//查找数据
-(NSArray*)syncSearchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type;

//直接执行SQL语句
-(void)rawSql:(NSString*) sql Classtype:(FSO)type callback:(void(^)(NSArray *))result;
-(NSArray*)syncRawSql:(NSString*)sql Classtype:(FSO)type;
@end
