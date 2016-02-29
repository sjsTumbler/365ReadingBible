//
//  SJSStatistricsViewController.m
//  Reading365
//
//  Created by SunJishuai on 16/1/28.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//  统计

#import "SJSStatistricsViewController.h"

@interface SJSStatistricsViewController ()

@end

@implementation SJSStatistricsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    
    [self.view setUserInteractionEnabled:YES];
    
    CGRect calenderRect = CGRectMake(0, navigationBarHight, viewWidth, 480);
    
    //  Example 1.1:
        self.unitView = [[JBUnitView alloc] initWithFrame:calenderRect UnitType:UnitTypeMonth SelectedDate:[NSDate date] AlignmentRule:JBAlignmentRuleTop Delegate:self DataSource:self];

//        self.view.backgroundColor = GetColor(redColor);
    
    
        [self.view addSubview:self.unitView];
    
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, self.unitView.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.unitView.bounds.size.height) style:UITableViewStylePlain];
        [self.view addSubview:self.tableView];
    
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(0.0f, 400.0f, 50.0f, 50.0f);
        [button setTitle:@"Today" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectorForButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    
    //  Example 1.2:
//        self.unitView = [[JBUnitView alloc] initWithFrame:calenderRect UnitType:UnitTypeWeek SelectedDate:[NSDate date] AlignmentRule:JBAlignmentRuleTop Delegate:self DataSource:self];
//        [self.view addSubview:self.unitView];
    
//        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, self.unitView.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.unitView.bounds.size.height) style:UITableViewStylePlain];
//        [self.view addSubview:self.tableView];
    
    
    //  Example 2.1:
//    JBUnitGridView *gridView = [[JBUnitGridView alloc] initWithFrame:calenderRect UnitType:UnitTypeMonth];
//    gridView.delegate = self;
//    gridView.dataSource = self;
//    [self.view addSubview:gridView];
//    [gridView setSelectedDate:[JBCalendarDate dateFromNSDate:[NSDate date]]];
    
    //  Example 2.2
    //    JBUnitGridView *gridView = [[JBUnitGridView alloc] initWithFrame:calenderRect UnitType:UnitTypeWeek];
    //    gridView.delegate = self;
    //    gridView.dataSource = self;
    //    [self.view addSubview:gridView];
    //    [gridView setSelectedDate:[JBCalendarDate dateFromNSDate:[NSDate date]]];
}
- (void)setNav {
    [self.SNavigationBar setTitle:@"统计"];
    [self.SNavigationBar setLeftBtn_parentName:@"读经"];
}

#pragma mark -
#pragma mark - Class Extensions
- (void)selectorForButton
{
    [self.unitView selectDate:[NSDate date]];
}

#pragma mark -
#pragma mark - JBUnitGridViewDelegate
/**************************************************************
 *@Description:获取当前UnitGridView中UnitTileView的高度
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:当前unitGridView中UnitTileView的高度
 **************************************************************/
- (CGFloat)heightOfUnitTileViewsInUnitGridView:(JBUnitGridView *)unitGridView
{
    return 46.0f;
}


/**************************************************************
 *@Description:获取当前UnitGridView中UnitTileView的宽度
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:当前UnitGridView中UnitTileView的宽度
 **************************************************************/
- (CGFloat)widthOfUnitTileViewsInUnitGridView:(JBUnitGridView *)unitGridView
{
    return 46.0f;
}


//  ------------选中了当前月份或周之外的时间--------------
/**************************************************************
 *@Description:选中了当前Unit的上一个Unit中的时间点
 *@Params:
 *  unitGridView:当前unitGridView
 *  date:选中的时间点
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView selectedOnPreviousUnitWithDate:(JBCalendarDate *)date
{
    
}

/**************************************************************
 *@Description:选中了当前Unit的下一个Unit中的时间点
 *@Params:
 *  unitGridView:当前unitGridView
 *  date:选中的时间点
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView selectedOnNextUnitWithDate:(JBCalendarDate *)date
{
    
}

#pragma mark -
#pragma mark - JBUnitGridViewDataSource
/**************************************************************
 *@Description:获得unitTileView
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:unitTileView
 **************************************************************/
- (JBUnitTileView *)unitTileViewInUnitGridView:(JBUnitGridView *)unitGridView
{
    return [[JBSXRCUnitTileView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 46.0f, 46.0f)];
}

/**************************************************************
 *@Description:设置unitGridView中的weekdaysBarView
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:weekdaysBarView
 **************************************************************/
- (UIView *)weekdaysBarViewInUnitGridView:(JBUnitGridView *)unitGridView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weekdaysBarView"]];
    return imageView;
}


/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件的数量
 *@Params:
 *  unitGridView:当前unitGridView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView NumberOfEventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSInteger eventCount))completedBlock
{
    completedBlock(calendarDate.day);
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件
 *@Params:
 *  unitGridView:当前unitGridView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView EventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSArray *events))completedBlock
{
    completedBlock(nil);
}


#pragma mark -
#pragma mark - JBUnitViewDelegate
/**************************************************************
 *@Description:获取当前UnitView中UnitTileView的高度
 *@Params:
 *  unitView:当前unitView
 *@Return:当前UnitView中UnitTileView的高度
 **************************************************************/
- (CGFloat)heightOfUnitTileViewsInUnitView:(JBUnitView *)unitView
{
    return 46.0f;
}

/**************************************************************
 *@Description:获取当前UnitView中UnitTileView的宽度
 *@Params:
 *  unitView:当前unitView
 *@Return:当前UnitView中UnitTileView的宽度
 **************************************************************/
- (CGFloat)widthOfUnitTileViewsInUnitView:(JBUnitView *)unitView
{
    return 46.0f;
}


/**************************************************************
 *@Description:更新unitView的frame
 *@Params:
 *  unitView:当前unitView
 *  newFrame:新的frame
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView UpdatingFrameTo:(CGRect)newFrame
{
    self.tableView.frame = CGRectMake(0.0f, newFrame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - newFrame.size.height);
}

/**************************************************************
 *@Description:重新设置unitView的frame
 *@Params:
 *  unitView:当前unitView
 *  newFrame:新的frame
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView UpdatedFrameTo:(CGRect)newFrame
{
    //NSLog(@"OK");
}

#pragma mark -
#pragma mark - JBUnitViewDataSource
/**************************************************************
 *@Description:获得unitTileView
 *@Params:
 *  unitView:当前unitView
 *@Return:unitTileView
 **************************************************************/
- (JBUnitTileView *)unitTileViewInUnitView:(JBUnitView *)unitView
{
    return [[JBSXRCUnitTileView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 46.0f, 46.0f)];
}

/**************************************************************
 *@Description:设置unitView中的weekdayView
 *@Params:
 *  unitView:当前unitView
 *@Return:weekdayView
 **************************************************************/
- (UIView *)weekdaysBarViewInUnitView:(JBUnitView *)unitView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weekdaysBarView"]];
    return imageView;
}

/**************************************************************
 *@Description:选择某一天
 *@Params:
 *  unitView:当前unitView
 *  date:选择的日期
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView SelectedDate:(NSDate *)date
{
    //NSLog(@"selected date:%@", date);
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件的数量
 *@Params:
 *  unitView:当前unitView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView NumberOfEventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSInteger eventCount))completedBlock
{
    completedBlock(calendarDate.day);
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件
 *@Params:
 *  unitView:当前unitView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView EventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSArray *events))completedBlock
{
    completedBlock(nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
