//
//  SJSReadNoteManager.m
//  Reading365
//
//  Created by SunJishuai on 16/2/4.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSReadNoteManager.h"

#define DBPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]stringByAppendingPathComponent:@"HolyBible.db"]

@implementation SJSReadNoteManager
//单例化
+ (SJSReadNoteManager *)sharedReadNoteManager {
    static SJSReadNoteManager *sharedReadNoteManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedReadNoteManagerInstance = [[self alloc] init];
    });
    return sharedReadNoteManagerInstance;
}
//计算动态cell高度
- (NSMutableArray *)getAutoCellHeightByModels:(NSMutableArray *)modelArry Type:(FSO)type{
    NSString * bibleContent = @"";
    NSMutableArray * cellHeightArray = [[NSMutableArray alloc]init];
    switch (type) {
        case new_cuv:{
            for(new_cuvModel * model in modelArry) {
                bibleContent = model.content;
                CGSize contentSize = [[PublicFunctions sharedPublicFunctions]getHeightByWidth:viewWidth-edages*2 Font: cellFont Text:bibleContent LineBreakMode:NSLineBreakByWordWrapping];
                [cellHeightArray addObject:[NSString stringWithFormat:@"%f",contentSize.height+labelHeight]];
            }
        }
            break;
        case new_ncv:{
            for(new_ncvModel * model in modelArry) {
                bibleContent = model.content;
                CGSize contentSize = [[PublicFunctions sharedPublicFunctions]getHeightByWidth:viewWidth-edages*2 Font: cellFont Text:bibleContent LineBreakMode:NSLineBreakByWordWrapping];
                [cellHeightArray addObject:[NSString stringWithFormat:@"%f",contentSize.height+labelHeight]];
            }
        }
            break;
        case new_niv:{
            for(new_nivModel * model in modelArry) {
                bibleContent = model.content;
                CGSize contentSize = [[PublicFunctions sharedPublicFunctions]getHeightByWidth:viewWidth-edages*2 Font: cellFont Text:bibleContent LineBreakMode:NSLineBreakByWordWrapping];
                [cellHeightArray addObject:[NSString stringWithFormat:@"%f",contentSize.height+labelHeight]];
            }
        }
            break;
        case old_cuv:{
            for(old_cuvModel * model in modelArry) {
                bibleContent = model.content;
                CGSize contentSize = [[PublicFunctions sharedPublicFunctions]getHeightByWidth:viewWidth-edages*2 Font: cellFont Text:bibleContent LineBreakMode:NSLineBreakByWordWrapping];
                [cellHeightArray addObject:[NSString stringWithFormat:@"%f",contentSize.height+labelHeight]];
            }
        }
            break;
        case old_ncv:{
            for(old_ncvModel * model in modelArry) {
                bibleContent = model.content;
                CGSize contentSize = [[PublicFunctions sharedPublicFunctions]getHeightByWidth:viewWidth-edages*2 Font: cellFont Text:bibleContent LineBreakMode:NSLineBreakByWordWrapping];
                [cellHeightArray addObject:[NSString stringWithFormat:@"%f",contentSize.height+labelHeight]];
            }
        }
            break;
        case old_niv:{
            for(old_nivModel * model in modelArry) {
                bibleContent = model.content;
                CGSize contentSize = [[PublicFunctions sharedPublicFunctions]getHeightByWidth:viewWidth-edages*2 Font: cellFont Text:bibleContent LineBreakMode:NSLineBreakByWordWrapping];
                [cellHeightArray addObject:[NSString stringWithFormat:@"%f",contentSize.height+labelHeight]];
            }
        }
            break;
        default:
            break;
    }
    return cellHeightArray;
}
#pragma mark 根据经文字典从数据库中找到对应的经文并返回
/**
 @author Jesus         , 16-02-02 17:02:26
 
 @brief 根据经文字典从数据库中找到对应的经文并返回
 
 @param searchDic 经文字典
 
 @return 对应的经文
 */
- (NSMutableArray *)searchBibleByDataDic:(NSDictionary *)searchDic  DBType:(FSO)type{
    
    if ([[ReadPlistManager sharedReadPlistManager]isFilePathExist:DBPath isDir:NO]) {
        long start = [[searchDic objectForKey:@"startNumber0"]longValue];
        long end   = [[searchDic objectForKey:@"endNumber0"]longValue];
        NSMutableArray * result = [[NSMutableArray alloc]init];
        [result addObjectsFromArray:[self getBibleContentByStart:start End:end Type:type]];
        if ([[searchDic objectForKey:@"startNumber1"]floatValue] ==0) {
            return result;
        }else {
            long start = [[searchDic objectForKey:@"startNumber1"]longValue];
            long end   = [[searchDic objectForKey:@"endNumber1"]longValue];
            [result addObjectsFromArray:[self getBibleContentByStart:start End:end Type:type]];
        }
        if ([[searchDic objectForKey:@"startNumber2"]floatValue] ==0) {
            return result;
        }else {
            long start = [[searchDic objectForKey:@"startNumber2"]longValue];
            long end   = [[searchDic objectForKey:@"endNumber2"]longValue];
            [result addObjectsFromArray:[self getBibleContentByStart:start End:end Type:type]];
        }
        if ([[searchDic objectForKey:@"startNumber3"]floatValue] ==0) {
            return result;
        }else {
            long start = [[searchDic objectForKey:@"startNumber3"]longValue];
            long end   = [[searchDic objectForKey:@"endNumber3"]longValue];
            [result addObjectsFromArray:[self getBibleContentByStart:start End:end Type:type]];
        }
        if ([[searchDic objectForKey:@"startNumber4"]floatValue] ==0) {
            return result;
        }else {
            long start = [[searchDic objectForKey:@"startNumber4"]longValue];
            long end   = [[searchDic objectForKey:@"endNumber4"]longValue];
            [result addObjectsFromArray:[self getBibleContentByStart:start End:end Type:type]];
        }
        return result;
    }else{
        return nil;
    }
}
- (NSMutableArray *)getBibleContentByStart:(long)start End:(long)end Type:(FSO)type {
    NSMutableArray * result = [[NSMutableArray alloc]init];
    for (long i = start; i <= end; i++) {
        NSMutableDictionary * search = [NSMutableDictionary dictionary];
        [search setValue:[NSString stringWithFormat:@"%lu",i] forKey:@"orderid"];
        [[DataFactory shardDataFactory]searchWhere:search orderBy:nil offset:0 count:10 Classtype:type callback:^(NSArray *resultArray) {
            if (resultArray.count > 0) {
                [result addObject:[resultArray firstObject]];
            }
        }];
    }
    return result;
}
#pragma mark   根据chapterNumber从数据库中找到对应的经文并返回
/**
 @author Jesus       , 16-02-11 18:02:49
 
 @brief 根据chapterNumber从数据库中找到对应的经文并返回
 
 @param chapterNumber 经文卷章
 @param type 数据库类型
 
 @return models
 */
- (NSMutableArray *)searchBibleBychapterNumber:(NSString *)chapterNumber DBType:(FSO)type {
    NSMutableArray * result = [[NSMutableArray alloc]init];
    NSMutableDictionary * search = [NSMutableDictionary dictionary];
    [search setValue:chapterNumber forKey:@"chapterNumber"];
    [[DataFactory shardDataFactory]searchWhere:search orderBy:@"section" offset:0 count:200 Classtype:type callback:^(NSArray *resultArray) {
        if (resultArray.count > 0) {
            [result addObjectsFromArray:resultArray];
        }
    }];
    return result;
}
#pragma mark     收藏经文
/**
 @author Jesus     , 16-02-25 21:02:59
 
 @brief  收藏经文
 
 @param type    经文表
 @param orderid 经文唯一字段
 
 @return 是否保存成功
 */
- (BOOL)saveBibleWithType:(int)type orderid:(NSString *)orderid {
    CollectionModel * model = [[CollectionModel alloc]init];
    model.bibleType = type;
    model.orderid = orderid;
    model.collectionid = [NSString stringWithFormat:@"%d%@",type,orderid];
    model.dateTime = [[PublicFunctions sharedPublicFunctions]getDateTime_Now];
    [[DataFactory shardDataFactory]insertToDB:model Classtype:collection];
    return YES;
}
@end
