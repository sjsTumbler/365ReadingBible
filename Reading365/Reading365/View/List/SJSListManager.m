//
//  SJSListManager.m
//  Reading365
//
//  Created by SunJishuai on 16/2/11.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSListManager.h"
#import "IndexingModel.h"

@implementation SJSListManager
+ (SJSListManager *)sharedListManager {
    static SJSListManager *sharedListManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedListManagerInstance = [[self alloc] init];
    });
    return sharedListManagerInstance;
}
#pragma mark  根据经卷编号查找经卷
/**
 @author Jesus  , 16-02-11 17:02:37
 
 @brief 根据经卷编号查找经卷
 
 @param index 编号
 
 @return 经卷model
 */
- (IndexingModel *)getBibleByIndex:(int)index {
    __block IndexingModel * model ;
    NSMutableDictionary * search = [NSMutableDictionary dictionary];
    [search setValue:[NSString stringWithFormat:@"%d",index] forKey:@"bibleid"];
    [[DataFactory shardDataFactory]searchWhere:search orderBy:nil offset:0 count:10 Classtype:indexing callback:^(NSArray *resultArray) {
        if (resultArray.count > 0) {
            model = [resultArray firstObject];
        }
    }];
    if(model != nil){
        return model;
    }else{
        return nil;
    }
}
@end
