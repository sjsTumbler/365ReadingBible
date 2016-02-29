//
//  CollectionModel.m
//  Reading365
//
//  Created by SunJishuai on 16/2/25.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "CollectionModel.h"

@implementation CollectionModelBase

+(Class)getBindingModelClass
{
    return [CollectionModel class];//返回model实体
}
const static NSString* tablename = @"collection";//表名
+(const NSString *)getTableName
{
    return tablename;
}

@end

@implementation CollectionModel
-(id)init
{
    self = [super init];
    if (self)
    {
        self.primaryKey = @"collectionid";//主健
    }
    return self;
}
- (id)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self)
    {
        _collectionid =  [dic objectForKey:@"collectionid"];
        _orderid      =  [dic objectForKey:@"orderid"];
        _bibleType    =  [[dic objectForKey:@"bibleType"]intValue];
        _dateTime     =  [[dic objectForKey:@"dateTime"]intValue];
    }
    return self;
}
-(void)dealloc
{
    [_collectionid  release];
    [_orderid       release];
    [super          dealloc];
}
@end