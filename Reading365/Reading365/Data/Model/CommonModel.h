//
//  CommonModel.h
//  Reading365
//
//  Created by SunJishuai on 16/2/27.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonModel : NSObject

@property(assign,nonatomic)  int          type;             //经卷
@property(copy,nonatomic)    NSString   * abbre;            //简称
@property(copy,nonatomic)    NSString   * chapterSection;   //章节
@property(copy,nonatomic)    NSString   * content;          //经文
@property(assign,nonatomic)    int        chapter;          //章编号
@property(assign,nonatomic)    int        section;          //节编号
@property(copy,nonatomic)    NSString   * bibleNumber;      //书编号(3位，旧约以1开头，新约以2开头)
@property(copy,nonatomic)    NSString   * orderid;          //书章节编号（9位，每三位对应书、章、节）
@property(copy,nonatomic)    NSString   * chapterNumber;    //书章编号（6位，每三位对应书章）
@property(assign,nonatomic)  double       dateTime;         //时间 

@end
