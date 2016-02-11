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
@property(copy,nonatomic)    NSString   * b_id;     //经卷编码（唯一字段）
@property(copy,nonatomic)    NSString   * EN;       //英文名
@property(copy,nonatomic)    NSString   * CH;       //中文名
@property(copy,nonatomic)    NSString   * TOTALNUM; //总共章数
@property(copy,nonatomic)    NSString   * CH_Abbre; //中文简称
@property(copy,nonatomic)    NSString   * EN_Abbre; //英文简称
@property(copy,nonatomic)    NSString   * CHT;      //中文繁体
@property(copy,nonatomic)    NSString   * CHT_Abbre;//中文繁体简称

- (id)init;
- (id)initWithJsonDictionary:(NSDictionary*)dic;
@end