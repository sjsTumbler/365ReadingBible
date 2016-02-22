//
//  SJSListViewController.m
//  Reading365
//
//  Created by SunJishuai on 16/1/28.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//  目录索引
/*
列表模式  和  平铺模式
*/
#import "SJSListViewController.h"

@interface SJSListViewController ()

@end
@implementation SJSListViewController
{
    SJSSegment         * _segCon;//分段控制器
    UIScrollView       * _baseScrollView;
    int                  _oldOrNew;//0-old,1-new
    int                  _tableOrCollection;//0-table,1-collection
    SJSListShowViewController * _oldListShowView;
    SJSListShowViewController * _newListShowView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self setNav];
    [self setSegmnet];
    [self setScroll];
}
- (void)initData {
    //加载默认的经文卷和展示方式
    NSString * oldOrNew = [[PublicFunctions sharedPublicFunctions]NSUserDefaults_ReadWithKey:Old_New_Bible];
    if ([[PublicFunctions sharedPublicFunctions]isBlankString:oldOrNew]) {
        [[PublicFunctions sharedPublicFunctions]NSUserDefaults_SaveEditWithValue:@"0" Key:Old_New_Bible];
        _oldOrNew = 0;
    }else{
        _oldOrNew = [oldOrNew intValue];
    }
    
    NSString * tableOrCollection = [[PublicFunctions sharedPublicFunctions]NSUserDefaults_ReadWithKey:List_Table_Collection];
    if ([[PublicFunctions sharedPublicFunctions]isBlankString:tableOrCollection]) {
        [[PublicFunctions sharedPublicFunctions]NSUserDefaults_SaveEditWithValue:@"0" Key:List_Table_Collection];
        _tableOrCollection = 0;
    }else{
        _tableOrCollection = [tableOrCollection intValue];
    }
}
- (void)setNav {
    [self.SNavigationBar setTitle:@"目录索引"];
    [self.SNavigationBar setLeftBtn_parentName:@"读经"];
    NSString * rightTitle= @"";
    if (_tableOrCollection == 0) {
        rightTitle = @"矩阵";
    }else if (_tableOrCollection == 1) {
        rightTitle = @"列表";
    }
    [self.SNavigationBar setRightBtnTitle:rightTitle];
}
- (void)SJSNavigationLeftAction:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:ShowTabbar object:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)SJSNavigationRightAction:(UIButton *)sender {
    if (_tableOrCollection == 0) {//显示矩阵，隐藏列表
        
        _tableOrCollection = 1;
        [self.SNavigationBar editRightBtnTitle:@"列表"];
        [[PublicFunctions sharedPublicFunctions]NSUserDefaults_SaveEditWithValue:@"1" Key:List_Table_Collection];
    }else if (_tableOrCollection == 1){//显示列表，隐藏矩阵
        _tableOrCollection = 0;
        [self.SNavigationBar editRightBtnTitle:@"矩阵"];
        [[PublicFunctions sharedPublicFunctions]NSUserDefaults_SaveEditWithValue:@"0" Key:List_Table_Collection];
    }
    [_oldListShowView setTableOrCollection:_tableOrCollection];
    [_newListShowView setTableOrCollection:_tableOrCollection];
}
//设置分段处理器
- (void)setSegmnet {
    // 分段选择器
    _segCon = [[SJSSegment alloc]initSegmentWithFrame:CGRectMake(0, navigationBarHight , viewWidth, segmentHeight) TitleList:[NSArray arrayWithObjects:@"旧约",@"新约", nil]];
    // 设置默认值
    _segCon.indexDefaults = _oldOrNew;
    _segCon.delegate = self;
    [self.view addSubview:_segCon];
}

#pragma mark  ShowListDelegate_点击“卷章”,进入对应经文的阅读
/**
 @author Jesus       , 16-02-12 00:02:06
 
 @brief 点击“卷章”,进入对应经文的阅读
 
 @param index collection
 */
- (void)didSelectedShowListCollectionWithTitle:(NSString *)title DataType:(FSO)type SectionName:(NSString *)sectionName k_id:(NSString *)k_id {
        SJSReadNoteViewController * rnvc = [[SJSReadNoteViewController alloc]init];
        rnvc.readType = indexing;
        rnvc.viewTitle = title;
        rnvc.dataType = type;
        rnvc.sectionName = sectionName;
        rnvc.k_id = k_id;
        [self.navigationController pushViewController:rnvc animated:NO];
}

#pragma mark   设置ScrollView
/**
 @author Jesus       , 16-02-22 13:02:38
 
 @brief 设置ScrollView
 */
- (void)setScroll {
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, navigationBarHight+segmentHeight,viewWidth, viewHeight-navigationBarHight-segmentHeight)];
    _baseScrollView.bounces = NO;
    _baseScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (_oldOrNew == 0) {
        _baseScrollView.contentOffset = CGPointMake(0, 0);
    }else if (_oldOrNew == 1){
        _baseScrollView.contentOffset = CGPointMake(viewWidth, 0);
    }
    _baseScrollView.pagingEnabled = YES;
    _baseScrollView.showsHorizontalScrollIndicator = NO;
    _baseScrollView.scrollEnabled = YES;
    _baseScrollView.userInteractionEnabled = YES;
    _baseScrollView.delegate = self;
    _baseScrollView.contentSize = CGSizeMake(2*viewWidth, 0);
    
    _oldListShowView = [[SJSListShowViewController alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-navigationBarHight-segmentHeight) Old_new:0 Table_collection:_tableOrCollection];
    _oldListShowView.delegate = self;
    [_baseScrollView addSubview:_oldListShowView.view];
    
    
    _newListShowView = [[SJSListShowViewController alloc]initWithFrame:CGRectMake(viewWidth, 0, viewWidth, viewHeight-navigationBarHight-segmentHeight) Old_new:1 Table_collection:_tableOrCollection];
    _newListShowView.delegate = self;
    [_baseScrollView addSubview:_newListShowView.view];
    
    [self.view addSubview:_baseScrollView];
}
#pragma mark - UIScrollViewDelegate
//实现LGSegment代理方法
-(void)scrollToPage:(int)Page {
    CGPoint offset = _baseScrollView.contentOffset;
    offset.x = self.view.frame.size.width * Page;
    [UIView animateWithDuration:0.3 animations:^{
        _baseScrollView.contentOffset = offset;
    }];
}
// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_segCon moveToOffsetX:scrollView.contentOffset.x];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
