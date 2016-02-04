//
//  SJSReadNotePopView.h
//  Reading365
//
//  Created by SunJishuai on 16/2/4.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJSReadNotePopView : UIView
+ (void)configCustomPopViewWithFrame:(CGRect)frame imagesArr:(NSArray *)imagesArr dataSourceArr:(NSArray *)dataourceArr anchorPoint:(CGPoint)anchorPoint seletedRowForIndex:(void(^)(NSInteger index))action animation:(BOOL)animation timeForCome:(NSTimeInterval)come timeForGo:(NSTimeInterval)go;
+ (void)removed;

@end
