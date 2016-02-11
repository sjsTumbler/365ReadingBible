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
const static NSString* tablename = @"t_CH_EN";//表名
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
        self.primaryKey = @"b_id";//主健
    }
    return self;
}
- (id)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self)
    {
        _b_id     = [dic objectForKey:@"b_id"];
        _EN       = [dic objectForKey:@"EN"];
        _CH       = [dic objectForKey:@"CH"];
        _CHT      = [dic objectForKey:@"CHT"];
        _TOTALNUM = [dic objectForKey:@"TOTALNUM"];
        _CH_Abbre = [dic objectForKey:@"CH_Abbre"];
        _EN_Abbre = [dic objectForKey:@"EN_Abbre"];
        _CHT_Abbre= [dic objectForKey:@"CHT_Abbre"];
    }
    return self;
}
-(void)dealloc
{
    [_b_id         release];
    [_EN           release];
    [_CH           release];
    [_CHT          release];
    [_TOTALNUM     release];
    [_CH_Abbre     release];
    [_EN_Abbre     release];
    [_CHT_Abbre    release];
    [super         dealloc];
}
@end



