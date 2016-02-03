//
//  DefineManager.h
//  Reading365
//
//  Created by SunJishuai on 16/2/2.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#ifndef Reading365_DefineManager_h
#define Reading365_DefineManager_h

#define DATABASE_FILE_NAME @"HolyBible.db"
#define PlistName @"Reading365List"
#define DBPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]stringByAppendingPathComponent:@"HolyBible.db"]
//[[NSBundle mainBundle]pathForResource:@"HolyBible" ofType:@"db"]
#endif
