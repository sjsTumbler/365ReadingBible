//
//  new_cuvModel.m
//  365_dayBibleReadingPlan
//
//  Created by Sun jishuai on 15/7/12.
//  Copyright (c) 2015年 SunJishuai. All rights reserved.
//  和合本_新约

#import "new_cuvModel.h"

@implementation new_cuvModelBase
+(Class)getBindingModelClass
{
    return [new_cuvModel class];//返回model实体
}
const static NSString* tablename = @"new_cuv";//表名
+(const NSString *)getTableName
{
    return tablename;
}
@end

@implementation new_cuvModel
//@synthesize Col001;
//@synthesize Col002;
//@synthesize Col003;
//@synthesize col_004;
//@synthesize col_005;
//@synthesize col_006;
//@synthesize o_id;
//@synthesize k_id;


-(id)init
{
    self = [super init];
    if (self)
    {
        self.primaryKey = @"o_id";//主健
    }
    return self;
}
- (id)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self)
    {
        _Col001       =  [dic objectForKey:@"Col001"];
        _Col002       =  [dic objectForKey:@"Col002"];
        _Col003       =  [dic objectForKey:@"Col003"];
        _col_004      =  [dic objectForKey:@"col004"];
        _col_005      =  [dic objectForKey:@"col005"];
        _col_006      =  [dic objectForKey:@"col006"];
        _o_id         =  [dic objectForKey:@"o_id"];
        _k_id         =  [dic objectForKey:@"k_id"];
    }
    return self;
}
-(void)dealloc
{
    [_Col001   release];
    [_Col002   release];
    [_Col003   release];
    [_col_004  release];
    [_col_005  release];
    [_col_006  release];
    [_o_id     release];
    [_k_id     release];
    [super     dealloc];
}

@end