//
//  StatusModel.m
//  Reading365
//
//  Created by SunJishuai on 16/2/10.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "StatusModel.h"

@implementation StatusModelBase
+(Class)getBindingModelClass
{
    return [StatusModel class];//返回model实体
}
const static NSString* tablename = @"status";//表名
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation StatusModel

-(id)init
{
    self = [super init];
    if (self)
    {
        self.primaryKey = @"onlyTag";//主健
    }
    return self;
}
- (id)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self)
    {
        _onlyTag       =  [dic objectForKey:@"onlyTag"];
        _status        =  [dic objectForKey:@"status"];
    }
    return self;
}
-(void)dealloc
{
    [_onlyTag  release];
    [_status   release];
    [super     dealloc];
}
@end
