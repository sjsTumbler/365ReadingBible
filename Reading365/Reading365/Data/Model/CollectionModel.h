//
//  CollectionModel.h
//  Reading365
//
//  Created by SunJishuai on 16/2/25.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//  收藏

#import "LKDaoBase.h"

@interface CollectionModelBase : LKDAOBase

@end


@interface CollectionModel : LKModelBase

@property (copy,nonatomic)   NSString *   collectionid;//唯一字段（10位数字，首位为经卷号，后九位为经文的唯一字段orderid）
/*
 old_cuv,//和合本旧约  1
 old_ncv,//新译本旧约  2
 old_niv,//英文版旧约  3
 new_cuv,//和合本新约  4
 new_ncv,//新译本新约  5
 new_niv,//英文版新约  6
 */
@property(assign,nonatomic) int         bibleType;//经卷编号
@property(copy,nonatomic)   NSString *  orderid;     //书章节编号（9位，每三位对应书、章、节）
@property(assign,nonatomic) double      dateTime;


- (id)init;
- (id)initWithJsonDictionary:(NSDictionary*)dic;

@end