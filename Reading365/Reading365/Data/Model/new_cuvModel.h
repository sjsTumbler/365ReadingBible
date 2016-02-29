//
//  new_cuvModel.h
//  365_dayBibleReadingPlan
//
//  Created by Sun jishuai on 15/7/12.
//  Copyright (c) 2015年 SunJishuai. All rights reserved.
//  和合本_新约

#import <Foundation/Foundation.h>
#import "LKDaoBase.h"
@interface new_cuvModelBase:LKDAOBase

@end

@interface new_cuvModel:LKModelBase

@property(copy,nonatomic)    NSString   * abbre;   //简称
@property(copy,nonatomic)    NSString   * chapterSection;   //章节
@property(copy,nonatomic)    NSString   * content;   //经文
@property(assign,nonatomic)    int        chapter;  //章编号
@property(assign,nonatomic)    int        section;  //节编号
@property(copy,nonatomic)    NSString   * bibleNumber;  //书编号(3位，旧约以1开头，新约以2开头)
@property(copy,nonatomic)    NSString   * orderid;     //书章节编号（9位，每三位对应书、章、节）
@property(copy,nonatomic)    NSString   * chapterNumber;     //书章编号（6位，每三位对应书章）

- (id)init;
- (id)initWithJsonDictionary:(NSDictionary*)dic;
@end