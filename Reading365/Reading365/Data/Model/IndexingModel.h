//
//  IndexingModel.h
//  Reading365
//
//  Created by SunJishuai on 16/2/11.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//  索引

#import "LKDaoBase.h"

@interface IndexingModelBase : LKDAOBase

@end
@interface IndexingModel:LKModelBase
//101-139   201-227
@property(copy,nonatomic)    NSString   * bibleid;     //经卷编码（唯一字段）
@property(copy,nonatomic)    NSString   * english;       //英文名
@property(copy,nonatomic)    NSString   * chinese;       //中文名
@property(assign,nonatomic)    int        totalNumber; //总共章数
@property(copy,nonatomic)    NSString   * chineseAbbre; //中文简称
@property(copy,nonatomic)    NSString   * englishAbbre; //英文简称

- (id)init;
- (id)initWithJsonDictionary:(NSDictionary*)dic;
@end