//
//  SJSCollectionManager.h
//  Reading365
//
//  Created by SunJishuai on 16/2/25.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJSCollectionManager : NSObject
+ (SJSCollectionManager *)sharedCollectionManager;
//获取所有收藏经文
- (NSMutableArray *)getAllCollectionBible;
//获取经文的动态高度
- (NSMutableArray *)getHeightOfCell:(NSMutableArray *)dataArray;
//根据commonModel删除真正的model
- (void)deleteCollectionModelByCommonModel:(CommonModel *)commonModel;
@end
