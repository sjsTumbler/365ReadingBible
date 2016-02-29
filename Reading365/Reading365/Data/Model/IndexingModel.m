//
//  IndexingModel.m
//  Reading365
//
//  Created by SunJishuai on 16/2/11.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "IndexingModel.h"

@implementation IndexingModelBase
+(Class)getBindingModelClass
{
    return [IndexingModel class];//返回model实体
}
const static NSString* tablename = @"indexing";//表名
+(const NSString *)getTableName
{
    return tablename;
}
@end

@implementation IndexingModel
-(id)init
{
    self = [super init];
    if (self)
    {
        self.primaryKey = @"bibleid";//主健
    }
    return self;
}
- (id)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self)
    {
        _bibleid      = [dic objectForKey:@"bibleid"];
        _english      = [dic objectForKey:@"english"];
        _chinese      = [dic objectForKey:@"chinese"];
        _totalNumber  = [[dic objectForKey:@"totalNumber"]intValue];
        _chineseAbbre = [dic objectForKey:@"chineseAbbre"];
        _englishAbbre = [dic objectForKey:@"englishAbbre"];
    }
    return self;
}
-(void)dealloc
{
    [_bibleid       release];
    [_english       release];
    [_chinese       release];
    [_chineseAbbre  release];
    [_englishAbbre  release];
    [super          dealloc];
}
@end



