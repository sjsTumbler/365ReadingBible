//
//  DataFactory.m
//  
//
//  Created by mac  on 12-12-7.
//  Copyright (c) 2012年 sky. All rights reserved.
//

#import "DataFactory.h"
static FMDatabaseQueue* queue;
@implementation DataFactory
@synthesize classValues;
+(DataFactory *)shardDataFactory
{
    static id ShardInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ShardInstance=[[self alloc]init];
    });
    return ShardInstance;
}
-(BOOL)IsDataBase
{
    BOOL Value=NO;
    if (![SandboxFile IsFileExists:GetDataBasePath])
    {
        Value=YES;
    }
    return Value;
}
-(void)CreateDataBase
{
    queue=[[[FMDatabaseQueue alloc]initWithPath:GetDataBasePath]autorelease];
}
-(void)CreateTable
{
    [[[TestModelBase alloc]initWithDBQueue:queue]autorelease];
}
-(id)Factory:(FSO)type
{
    id result;
    queue=[[[FMDatabaseQueue alloc]initWithPath:GetDataBasePath]autorelease];
    switch (type)
    {
        case test:
            result=[[[TestModelBase alloc]initWithDBQueue:queue]autorelease];
            break;
        default:
            break;
    }
    return result;
}
-(void)insertToDB:(id)Model Classtype:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues insertToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"添加%d",Values);
     }];
}
-(void)updateToDB:(id)Model Classtype:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues updateToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"修改%d",Values);
     }];
}
-(void)deleteToDB:(id)Model Classtype:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues deleteToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"删除%d",Values);
     }];
}
-(void)clearTableData:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues clearTableData];
    NSLog(@"删除全部数据");
}
-(void)deleteWhereData:(NSDictionary *)Model Classtype:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues deleteToDBWithWhereDic:Model callback:^(BOOL Values)
     {
         NSLog(@"删除成功");
     }];
}
-(void)searchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(void(^)(NSArray *))result
{
    self.classValues=[self Factory:type];
    [classValues searchWhereDic:where orderBy:columeName offset:offset count:count callback:^(NSArray *array)
     {
         result(array);
     }];
}
-(void)dealloc
{
    [classValues release];
    NSLog(@"DataFactory dealloc");
    [super dealloc];
}
@end
