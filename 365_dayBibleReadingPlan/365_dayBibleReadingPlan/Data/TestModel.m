//
//  TestModel.m
//  Data
//
//  Created by mac  on 13-3-4.
//  Copyright (c) 2013年 Sky. All rights reserved.
//

#import "TestModel.h"
@implementation TestModelBase
+(Class)getBindingModelClass
{
    return [TestModel class];//返回商家实体
}
const static NSString* tablename = @"Test";//表名
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation TestModel
@synthesize Bid;
@synthesize StoreName;
@synthesize Longitude;
@synthesize Latitude;
-(id)init
{
    self = [super init];
    if (self)
    {
        self.primaryKey = @"Bid";//主健
    }
    return self;
}
- (id)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self)
    {
        self.Bid=[dic objectForKey:@"Bid"];
        self.StoreName=[dic objectForKey:@"StoreName"];
        self.Longitude=[dic objectForKey:@"Longitude"];
        self.Latitude=[dic objectForKey:@"Latitude"];
    }
    return self;
}
//===========================================================
// dealloc
//===========================================================
-(void)dealloc
{
    [Bid release];
    [StoreName release];
    [Longitude release];
    [Latitude release];
    NSLog(@"TestModel dealloc");
    [super dealloc];
}
@end

