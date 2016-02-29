//
//  SJSCollectionManager.m
//  Reading365
//
//  Created by SunJishuai on 16/2/25.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSCollectionManager.h"

@implementation SJSCollectionManager
+ (SJSCollectionManager *)sharedCollectionManager {
    static SJSCollectionManager *sharedCollectionManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedCollectionManagerInstance = [[self alloc] init];
    });
    return sharedCollectionManagerInstance;
}

#pragma mark  获取所有收藏经文
/**
 @author Jesus        , 16-02-25 22:02:17
 
 @brief 获取所有收藏经文
 
 @return model数组
 */
- (NSMutableArray *)getAllCollectionBible{
    NSMutableArray * collectionArray = [[NSMutableArray alloc]init];
    for (int type = 1; type <= 6; type++) {
        NSMutableDictionary * search = [NSMutableDictionary dictionary];
        [search setValue:[NSString stringWithFormat:@"%d",type] forKey:@"bibleType"];
        [[DataFactory shardDataFactory]searchWhere:search orderBy:@"dateTime desc" offset:0 count:100 Classtype:collection callback:^(NSArray *resultArray) {
            if (resultArray.count > 0) {
                for(CollectionModel * collection in resultArray) {
                switch (collection.bibleType) {
                    case 1:{
                        NSMutableDictionary * searchModel = [NSMutableDictionary dictionary];
                        [searchModel setValue:collection.orderid forKey:@"orderid"];
                        [[DataFactory shardDataFactory]searchWhere:searchModel orderBy:nil offset:0 count:10 Classtype:old_cuv callback:^(NSArray *resultArray) {
                            if(resultArray.count>0){
                                CommonModel * commonModel = [self newModelFromOld_cuvModel:[resultArray firstObject]];
                                commonModel.dateTime = collection.dateTime;
                                [collectionArray addObject:commonModel];
                            }
                        }];
                    }
                        break;
                    case 2:{
                        NSMutableDictionary * searchModel = [NSMutableDictionary dictionary];
                        [searchModel setValue:collection.orderid forKey:@"orderid"];
                        [[DataFactory shardDataFactory]searchWhere:searchModel orderBy:nil offset:0 count:10 Classtype:old_ncv callback:^(NSArray *resultArray) {
                            if(resultArray.count>0){
                                CommonModel * commonModel = [self newModelFromOld_ncvModel:[resultArray firstObject]];
                                commonModel.dateTime = collection.dateTime;
                                [collectionArray addObject:commonModel];
                            }
                        }];
                    }
                        break;
                    case 3:{
                        NSMutableDictionary * searchModel = [NSMutableDictionary dictionary];
                        [searchModel setValue:collection.orderid forKey:@"orderid"];
                        [[DataFactory shardDataFactory]searchWhere:searchModel orderBy:nil offset:0 count:10 Classtype:old_niv callback:^(NSArray *resultArray) {
                            if(resultArray.count>0){
                                CommonModel * commonModel = [self newModelFromOld_nivModel:[resultArray firstObject]];
                                commonModel.dateTime = collection.dateTime;
                                [collectionArray addObject:commonModel];
                            }
                        }];
                    }
                        break;
                    case 4:{
                        NSMutableDictionary * searchModel = [NSMutableDictionary dictionary];
                        [searchModel setValue:collection.orderid forKey:@"orderid"];
                        [[DataFactory shardDataFactory]searchWhere:searchModel orderBy:nil offset:0 count:10 Classtype:new_cuv callback:^(NSArray *resultArray) {
                            if(resultArray.count>0){
                                CommonModel * commonModel = [self newModelFromNew_cuvModel:[resultArray firstObject]];
                                commonModel.dateTime = collection.dateTime;
                                [collectionArray addObject:commonModel];
                            }
                        }];
                    }
                        break;
                    case 5:{
                        NSMutableDictionary * searchModel = [NSMutableDictionary dictionary];
                        [searchModel setValue:collection.orderid forKey:@"orderid"];
                        [[DataFactory shardDataFactory]searchWhere:searchModel orderBy:nil offset:0 count:10 Classtype:new_ncv callback:^(NSArray *resultArray) {
                            if(resultArray.count>0){
                                CommonModel * commonModel = [self newModelFromNew_ncvModel:[resultArray firstObject]];
                                commonModel.dateTime = collection.dateTime;
                                [collectionArray addObject:commonModel];
                            }
                        }];
                    }
                        break;
                    case 6:{
                        NSMutableDictionary * searchModel = [NSMutableDictionary dictionary];
                        [searchModel setValue:collection.orderid forKey:@"orderid"];
                        [[DataFactory shardDataFactory]searchWhere:searchModel orderBy:nil offset:0 count:10 Classtype:new_niv callback:^(NSArray *resultArray) {
                            if(resultArray.count>0){
                                CommonModel * commonModel = [self newModelFromNew_nivModel:[resultArray firstObject]];
                                commonModel.dateTime = collection.dateTime;
                                [collectionArray addObject:commonModel];
                            }
                        }];
                    }
                        break;
                    default:
                        break;
                }
            }
            }
        }];
    }
    return [[PublicFunctions sharedPublicFunctions]sortingArray:collectionArray Property:@"dateTime" Ascending:NO];
}

//old_cuv,和合本旧约
- (CommonModel *)newModelFromOld_cuvModel:(old_cuvModel *)model{
    CommonModel * newModel = [[CommonModel alloc]init];
    newModel.type = 1;
    newModel.abbre = model.abbre;
    newModel.chapterSection = model.chapterSection;
    newModel.content = model.content;
    newModel.chapter = model.chapter;
    newModel.section = model.section;
    newModel.bibleNumber = model.bibleNumber;
    newModel.orderid = model.orderid;
    newModel.chapterNumber = model.chapterNumber;
    return newModel;
}
//old_ncv,新译本旧约
- (CommonModel *)newModelFromOld_ncvModel:(old_ncvModel *)model{
    CommonModel * newModel = [[CommonModel alloc]init];
    newModel.type = 2;
    newModel.chapter = model.chapter;
    newModel.abbre = model.abbre;
    newModel.chapterSection = model.chapterSection;
    newModel.content = model.content;
    newModel.section = model.section;
    newModel.bibleNumber = model.bibleNumber;
    newModel.orderid = model.orderid;
    newModel.chapterNumber = model.chapterNumber;
    return newModel;
}
//old_niv,英文版旧约
- (CommonModel *)newModelFromOld_nivModel:(old_nivModel *)model{
    CommonModel * newModel = [[CommonModel alloc]init];
    newModel.type = 3;
    newModel.abbre = model.abbre;
    newModel.chapter = model.chapter;
    newModel.chapterSection = model.chapterSection;
    newModel.content = model.content;
    newModel.section = model.section;
    newModel.bibleNumber = model.bibleNumber;
    newModel.orderid = model.orderid;
    newModel.chapterNumber = model.chapterNumber;
    return newModel;
}
//new_cuv,和合本新约
- (CommonModel *)newModelFromNew_cuvModel:(new_cuvModel *)model{
    CommonModel * newModel = [[CommonModel alloc]init];
    newModel.type = 4;
    newModel.abbre = model.abbre;
    newModel.chapter = model.chapter;
    newModel.chapterSection = model.chapterSection;
    newModel.content = model.content;
    newModel.section = model.section;
    newModel.bibleNumber = model.bibleNumber;
    newModel.orderid = model.orderid;
    newModel.chapterNumber = model.chapterNumber;
    return newModel;
}
//new_ncv,新译本新约
- (CommonModel *)newModelFromNew_ncvModel:(new_ncvModel *)model{
    CommonModel * newModel = [[CommonModel alloc]init];
    newModel.type = 5;
    newModel.abbre = model.abbre;
    newModel.chapter = model.chapter;
    newModel.chapterSection = model.chapterSection;
    newModel.content = model.content;
    newModel.section = model.section;
    newModel.bibleNumber = model.bibleNumber;
    newModel.orderid = model.orderid;
    newModel.chapterNumber = model.chapterNumber;
    return newModel;
}
//new_niv,英文版新约
- (CommonModel *)newModelFromNew_nivModel:(new_nivModel *)model{
    CommonModel * newModel = [[CommonModel alloc]init];
    newModel.type = 6;
    newModel.abbre = model.abbre;
    newModel.chapter = model.chapter;
    newModel.chapterSection = model.chapterSection;
    newModel.content = model.content;
    newModel.section = model.section;
    newModel.bibleNumber = model.bibleNumber;
    newModel.orderid = model.orderid;
    newModel.chapterNumber = model.chapterNumber;
    return newModel;
}
#pragma mark    获取收藏经文cell的高度
/**
 @author Jesus      , 16-02-28 15:02:12
 
 @brief 获取收藏经文cell的高度
 
 @param dataArray
 
 @return 高度数组
 */
- (NSMutableArray *)getHeightOfCell:(NSMutableArray *)dataArray {
    NSMutableArray * heightArray = [[NSMutableArray alloc]init];
    for(CommonModel * model in dataArray){
        CGSize contentSize = [[PublicFunctions sharedPublicFunctions]getHeightByWidth:viewWidth-edages*2 Font: cellFont Text:model.content LineBreakMode:NSLineBreakByWordWrapping];
        [heightArray addObject:[NSString stringWithFormat:@"%f",contentSize.height+labelHeight*2]];
    }
    return heightArray;
}
#pragma mark
/**
 @author Jesus         , 16-02-28 15:02:01
 
 @brief 根据commonModel删除真正的model
 
 @param commonModel 
 */
- (void)deleteCollectionModelByCommonModel:(CommonModel *)commonModel {
    NSMutableDictionary * searchModel = [NSMutableDictionary dictionary];
    [searchModel setValue:commonModel.orderid forKey:@"orderid"];
    [searchModel setValue:[NSString stringWithFormat:@"%d",commonModel.type] forKey:@"bibleType"];
    [searchModel setValue:[NSString stringWithFormat:@"%f",commonModel.dateTime] forKey:@"dateTime"];
    [[DataFactory shardDataFactory]searchWhere:searchModel orderBy:nil offset:0 count:10 Classtype:collection callback:^(NSArray *resultArray) {
        if(resultArray.count>0){
            [[DataFactory shardDataFactory]deleteToDB:[resultArray firstObject] Classtype:collection];
        }
    }];
}
@end