//
//  TestModel.h
//  Data
//
//  Created by mac  on 13-3-4.
//  Copyright (c) 2013年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDaoBase.h"
@interface TestModelBase:LKDAOBase

@end

@interface TestModel:LKModelBase

@property(copy,nonatomic)NSString *Bid;
@property(copy,nonatomic)NSString *StoreName;
@property(copy,nonatomic)NSString *Longitude;
@property(copy,nonatomic)NSString *Latitude;

@end
