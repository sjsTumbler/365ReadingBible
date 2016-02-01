//
//  JBUnitTileView.m
//  JBCalendar
//
//  Created by YongbinZhang on 7/8/13.
//  Copyright (c) 2013 YongbinZhang
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "JBUnitTileView.h"
#import "LunarCalendar.h"


@interface JBUnitTileView ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGR;
- (void)selectorForTapGR:(UITapGestureRecognizer *)tapGR;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGR;
- (void)selectorForDoubleTapGR:(UITapGestureRecognizer *)doubleTapGR;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGR;
- (void)selectorForLongPressGR:(UILongPressGestureRecognizer *)longPressGR;

@end

@implementation JBUnitTileView

#pragma mark -
#pragma mark - init
- (id)initWithFrame:(CGRect)frame
{    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code        
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        
        
        self.eventCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 20.0f, 0.0f, 20.0f, 10.0f)];
        self.eventCountLabel.textColor = [UIColor lightGrayColor];
        self.eventCountLabel.font = [UIFont systemFontOfSize:9.0f];
        //self.eventCountLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.eventCountLabel];
        self.eventCountLabel.hidden = YES;
        
        
        self.dayLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.dayLabel.backgroundColor = [UIColor clearColor];
        self.dayLabel.textColor = [UIColor blackColor];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
        self.dayLabel.textAlignment = UITextAlignmentCenter;
#else
        self.dayLabel.textAlignment = NSTextAlignmentCenter;
#endif
        self.dayLabel.font = [UIFont boldSystemFontOfSize:DefaultFontSize_Month_Day];
        [self addSubview:self.dayLabel];
        
        
        self.lunarLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.lunarLabel.backgroundColor = [UIColor clearColor];
        self.lunarLabel.textColor = [UIColor lightGrayColor];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
        self.lunarLabel.textAlignment = UITextAlignmentCenter;
#else
        self.lunarLabel.textAlignment = NSTextAlignmentCenter;
#endif
        [self addSubview:self.lunarLabel];
        self.lunarLabel.hidden = YES;
        
        
        self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectorForTapGR:)];
        [self addGestureRecognizer:self.tapGR];
        
        self.doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectorForDoubleTapGR:)];
        [self.doubleTapGR setNumberOfTapsRequired:2];
        //[self addGestureRecognizer:self.doubleTapGR];
        
        self.longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(selectorForLongPressGR:)];
        [self addGestureRecognizer:self.longPressGR];
    }
    return self;
}


#pragma mark -
#pragma mark - Object Methods
//  更新界面显示
- (void)updateShowing
{    
    JBCalendarDate *today = [JBCalendarDate dateFromNSDate:[NSDate date]];
    if (NSOrderedSame == [today compare:self.date]) {
        [self updateUnitTileViewShowingWithOtherUnit:(self.previousUnit || self.nextUnit) Selected:self.selected Today:YES eventsCount:self.eventsCount];
    } else {
        [self updateUnitTileViewShowingWithOtherUnit:(self.previousUnit || self.nextUnit) Selected:self.selected Today:NO eventsCount:self.eventsCount];
    }
}


#pragma mark -
#pragma mark - 模版方法（不可以直接调用）
/****************************************************************
 *@Description:用户按下该Tile（模版方法）
 *@Params:nil
 *@Return:nil
 ***************************************************************/
- (void)tappedOnUnitTileView
{    
    //  TO DO
}

/****************************************************************
 *@Description:用户双击该Tile（模版方法）
 *@Params:nil
 *@Return:nil
 ***************************************************************/
//- (void)doubleTappedOnUnitTileView
//{    
//    //  TO DO
//}

/****************************************************************
 *@Description:用户长时间按下该Tile（模版方法）
 *@Params:nil
 *@Return:nil
 ***************************************************************/
- (void)longPressedOnUnitTileView
{    
    //  TO DO
}

/****************************************************************
 *@Description:根据UnitTile的状态设置界面显示
 *@Params:
 *  otherUnit:是否事当前Unit之外的日期
 *  selected:是否选中
 *  today:是否是当天
 *  eventsCount:该天的事件数量
 *@Return:nil
 ***************************************************************/
- (void)updateUnitTileViewShowingWithOtherUnit:(BOOL)otherUnit Selected:(BOOL)selected Today:(BOOL)today eventsCount:(NSInteger)eventsCount
{
    //  TO DO    
}


#pragma mark -
#pragma mark - Class Extensions
- (void)selectorForTapGR:(UITapGestureRecognizer *)tapGR
{    
    if (self.previousUnit) {
        if ([self.delegate respondsToSelector:@selector(tappedInPreviousUnitOnUnitTileView:)]) {
            [self.delegate tappedInPreviousUnitOnUnitTileView:self];
        }
    } else if (self.nextUnit) {
        if ([self.delegate respondsToSelector:@selector(tappedInNextUnitOnUnitTileView:)]) {
            [self.delegate tappedInNextUnitOnUnitTileView:self];
        }
    } else {
        if (!self.selected) {
            if ([self.delegate respondsToSelector:@selector(tappedInSelectedUnitOnUnitTileView:)]) {
                [self.delegate tappedInSelectedUnitOnUnitTileView:self];
            }
        }
        
        [self tappedOnUnitTileView];
    }
}

- (void)selectorForDoubleTapGR:(UITapGestureRecognizer *)doubleTapGR
{
    if (self.previousUnit || self.nextUnit) {
        
    } else {
        if (!self.selected) {
            self.selected = YES;
            [self updateShowing];
        }
        
        //    [self doubleTappedOnUnitTileView];
    }
}

- (void)selectorForLongPressGR:(UILongPressGestureRecognizer *)longPressGR
{    
    if (self.previousUnit || self.nextUnit) {
        
    } else {
        if (!self.selected) {
            self.selected = YES;
            [self updateShowing];
        }
        
        [self longPressedOnUnitTileView];
    }
}


#pragma mark -
#pragma mark - Settors
- (void)setDate:(JBCalendarDate *)date
{
    if (![date isEqual:_date]) {
        _date = date;
        
        if (self.dayLabel) {
            self.dayLabel.text = [NSString stringWithFormat:@"%li", (long)_date.day];
        }
        
        if (self.lunarLabel) {
            LunarCalendar *lunarCalendar = [[_date nsDate] chineseCalendarDate];
            if (lunarCalendar.SolarTermTitle.length <= 0) {
                self.lunarLabel.text = [NSString stringWithFormat:@"%@", lunarCalendar.DayLunar];
            } else {
                self.lunarLabel.text = [NSString stringWithFormat:@"%@", lunarCalendar.SolarTermTitle];
            }
        }
    }
}

@end