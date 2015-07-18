//
//  new_nivModel.m
//  365_dayBibleReadingPlan
//
//  Created by Sun jishuai on 15/7/12.
//  Copyright (c) 2015年 SunJishuai. All rights reserved.
//  英文版_新约

#import "new_nivModel.h"

@implementation new_nivModelBase
+(Class)getBindingModelClass
{
    return [new_nivModel class];//返回model实体
}
const static NSString* tablename = @"new_niv";//表名
+(const NSString *)getTableName
{
    return tablename;
}
@end

@implementation new_nivModel
@synthesize Col001;
@synthesize Col002;
@synthesize Col003;
@synthesize col_004;
@synthesize col_005;
@synthesize col_006;
@synthesize o_id;
@synthesize k_id;


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
        self.Col001      =  [dic objectForKey:@"Col001"];
        self.Col002  =  [dic objectForKey:@"Col002"];
        self.Col003       =  [dic objectForKey:@"Col003"];
        self.col_004         =  [dic objectForKey:@"col004"];
        self.col_005         =  [dic objectForKey:@"col005"];
        self.col_006            =  [dic objectForKey:@"col006"];
        self.o_id      =  [dic objectForKey:@"o_id"];
        self.k_id     =  [dic objectForKey:@"k_id"];
    }
    return self;
}
-(void)dealloc
{
    [Col001 release];
    [Col002 release];
    [Col003 release];
    [col_004 release];
    [col_005 release];
    [col_006 release];
    [o_id release];
    [k_id release];
    [super dealloc];
}

@end