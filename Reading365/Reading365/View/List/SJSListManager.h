//
//  SJSListManager.h
//  Reading365
//
//  Created by SunJishuai on 16/2/11.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelHeader.h"
#import "DataFactory.h"

@interface SJSListManager : NSObject
+ (SJSListManager *)sharedListManager;
//根据经卷编号查找经卷
- (IndexingModel *)getBibleByIndex:(int)index;
@end
