//
//  new_ncvModel.h
//  365_dayBibleReadingPlan
//
//  Created by Sun jishuai on 15/7/12.
//  Copyright (c) 2015年 SunJishuai. All rights reserved.
//  新译本_新约

#import <Foundation/Foundation.h>
#import "LKDaoBase.h"
@interface new_ncvModelBase:LKDAOBase

@end

@interface new_ncvModel:LKModelBase

@property(retain,nonatomic)    NSString   * shortTitle;        //简称
@property(retain,nonatomic)    NSString   * chapterSection;    //章节
@property(retain,nonatomic)    NSString   * scripture;         //经文
@property(retain,nonatomic)    NSString   * chapter;           //章编号
@property(retain,nonatomic)    NSString   * section;           //节编号
@property(retain,nonatomic)    NSString   * book;              //书编号(3位，旧约以1开头，新约以2开头)
@property(retain,nonatomic)    NSString   * generalNum;        //书章节编号（9位，每三位对应书、章、节）
@property(retain,nonatomic)    NSString   * generalNum2;       //书章编号（6位，每三位对应书章）

@end