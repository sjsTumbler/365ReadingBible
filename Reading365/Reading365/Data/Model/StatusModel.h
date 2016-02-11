//
//  StatusModel.h
//  Reading365
//
//  Created by SunJishuai on 16/2/10.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//  状态

#import "LKDaoBase.h"

@interface StatusModelBase : LKDAOBase

@end
@interface StatusModel : LKModelBase
/*
 唯一字段，9位数，
 前三位为版本 001:和合本
            002:繁体本
            003:英文本
 中间三位为天数，如第101天：101，
 后三位为对应的模块，旧约：001，新约：002，诗篇：003，箴言：004
 
 备注：在plist文件中没有添加前三位版本，以使其适用于多个不同版本，即plist文件的一个字典对应多个状态model
 
    此字段也用于对应经文的note
 
 锁定对应经文的唯一字段
 */
@property (copy,nonatomic)   NSString  * onlyTag;
@property (copy,nonatomic)   NSString  * status;//0为未读，1为已读
@property (assign,nonatomic)   int       version;//版本
@property (assign,nonatomic)   int       day;    //天
@property (assign,nonatomic)   int       part;   //经文的模块

- (id)init;
- (id)initWithJsonDictionary:(NSDictionary*)dic;
@end