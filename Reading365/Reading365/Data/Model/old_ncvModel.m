//
//  old_ncvModel.m
//  365_dayBibleReadingPlan
//
//  Created by Sun jishuai on 15/7/12.
//  Copyright (c) 2015年 SunJishuai. All rights reserved.
//  新译本_旧约

#import "old_ncvModel.h"

@implementation old_ncvModelBase
+(Class)getBindingModelClass
{
    return [old_ncvModel class];//返回model实体
}
const static NSString* tablename = @"old_ncv";//表名
+(const NSString *)getTableName
{
    return tablename;
}
@end

@implementation old_ncvModel
//@synthesize abbre;
//@synthesize chapterSection;
//@synthesize content;
//@synthesize chapter;
//@synthesize section;
//@synthesize bibleNumber;
//@synthesize orderid;
//@synthesize chapterNumber;


-(id)init
{
    self = [super init];
    if (self)
    {
        self.primaryKey = @"orderid";//主健
    }
    return self;
}
- (id)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self)
    {
        _abbre            =  [dic objectForKey:@"abbre"];
        _chapterSection   =  [dic objectForKey:@"chapterSection"];
        _content          =  [dic objectForKey:@"content"];
        _chapter          =  [[dic objectForKey:@"chapter"]intValue];
        _section          =  [[dic objectForKey:@"section"]intValue];
        _bibleNumber      =  [dic objectForKey:@"bibleNumber"];
        _orderid          =  [dic objectForKey:@"orderid"];
        _chapterNumber    =  [dic objectForKey:@"chapterNumber"];
    }
    return self;
}
-(void)dealloc
{
    [_abbre            release];
    [_chapterSection   release];
    [_content          release];
    [_bibleNumber      release];
    [_orderid          release];
    [_chapterNumber    release];
    [super             dealloc];
}

@end