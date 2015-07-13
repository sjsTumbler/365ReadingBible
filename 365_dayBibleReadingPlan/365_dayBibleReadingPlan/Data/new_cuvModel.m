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
    return [new_cuvModel class];//返回商家实体
}
const static NSString* tablename = @"new_cuv";//表名
+(const NSString *)getTableName
{
    return tablename;
}
@end

@implementation new_cuvModel
@synthesize shortTitle;
@synthesize chapterSection;
@synthesize scripture;
@synthesize chapter;
@synthesize section;
@synthesize book;
@synthesize generalNum;
@synthesize generalNum2;

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
        self.shortTitle      =  [dic objectForKey:@"Col001"];
        self.chapterSection  =  [dic objectForKey:@"Col002"];
        self.scripture       =  [dic objectForKey:@"Col003"];
        self.chapter         =  [dic objectForKey:@"col004"];
        self.section         =  [dic objectForKey:@"col005"];
        self.book            =  [dic objectForKey:@"col006"];
        self.generalNum      =  [dic objectForKey:@"o_id"];
        self.generalNum2     =  [dic objectForKey:@"k_id"];
    }
    return self;
}
-(void)dealloc
{
    [shortTitle release];
    [chapterSection release];
    [scripture release];
    [chapter release];
    [section release];
    [book release];
    [generalNum release];
    [generalNum2 release];
    [super dealloc];
}

@end