//
//  SJSReadNoteViewController.h
//  Reading365
//
//  Created by SunJishuai on 16/2/3.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "RootViewController.h"
//#import "ModelHeader.h"
#import "SJSReadNoteManager.h"
#import "SJSReadNotePopView.h"
#import "SJSReadNoteTableViewCell.h"

typedef NS_ENUM(NSInteger, readType){
    Plan     = 0 ,//计划读经
    Index  = 1 ,//索引读经
};

@interface SJSReadNoteViewController : RootViewController
<
UITableViewDelegate,
UITableViewDataSource,
ReadNoteTableViewCellDelegate>
@property(nonatomic,strong) NSMutableArray * dataArray;
@property(nonatomic,strong) NSString * viewTitle;
@property(nonatomic,strong) NSDictionary * dataDic;
@property(nonatomic,assign) FSO  dataType;
@property(nonatomic,assign) BOOL canCustomEdit;
@property(nonatomic,assign) readType readType;
@property(nonatomic,strong) NSString * chapterNumber;
@property(nonatomic,strong) NSString * sectionName;
@end
