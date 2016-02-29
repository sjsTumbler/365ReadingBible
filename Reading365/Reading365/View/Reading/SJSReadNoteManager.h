//
//  SJSReadNoteManager.h
//  Reading365
//
//  Created by SunJishuai on 16/2/4.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "ModelHeader.h"
#import "DataFactory.h"
#import "PublicFunctions.h"
#import "ReadPlistManager.h"

@interface SJSReadNoteManager : NSObject
+ (SJSReadNoteManager *)sharedReadNoteManager;
//计算动态cell高度
- (NSMutableArray *)getAutoCellHeightByModels:(NSMutableArray *)modelArry Type:(FSO)type;
//根据经文字典从数据库中找到对应的经文并返回
- (NSMutableArray *)searchBibleByDataDic:(NSDictionary *)searchDic DBType:(FSO)type;
//根据chapterNumber从数据库中找到对应的经文并返回
- (NSMutableArray *)searchBibleBychapterNumber:(NSString *)chapterNumber DBType:(FSO)type;
//收藏经文
- (BOOL)saveBibleWithType:(int)type orderid:(NSString *)orderid;
@end
