//
//  old_cuvModel.h
//  365_dayBibleReadingPlan
//
//  Created by Sun jishuai on 15/7/12.
//  Copyright (c) 2015年 SunJishuai. All rights reserved.
//  和合本_旧约

#import <Foundation/Foundation.h>
#import "LKDaoBase.h"
@interface old_cuvModelBase:LKDAOBase

@end

@interface old_cuvModel:LKModelBase

@property(copy,nonatomic)    NSString   * Col001;   //简称
@property(copy,nonatomic)    NSString   * Col002;   //章节
@property(copy,nonatomic)    NSString   * Col003;   //经文
@property(copy,nonatomic)    NSString   * col_004;  //章编号
@property(copy,nonatomic)    NSString   * col_005;  //节编号
@property(copy,nonatomic)    NSString   * col_006;  //书编号(3位，旧约以1开头，新约以2开头)
@property(copy,nonatomic)    NSString   * o_id;     //书章节编号（9位，每三位对应书、章、节）
@property(copy,nonatomic)    NSString   * k_id;     //书章编号（6位，每三位对应书章）

-(id)init;
- (id)initWithJsonDictionary:(NSDictionary*)dic;
@end