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
    UISegmentedControl * _segCon;
    int                  _oldOrNew;//0-old,1-new
    NSMutableArray     * _oldList;
    NSMutableArray     * _newList;
    NSMutableArray     * _showList;
    UITableView        * _listTable;
    NSInteger        _currentSection;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self setNav];
    [self setSegmnet];
    [self setTable];
}
- (void)initData {
    _oldList = [[NSMutableArray alloc]init];
    _newList = [[NSMutableArray alloc]init];
    //101-139
    for (int i = 101; i<=139; i++) {
        HeadView* headview = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, moreListSectionHeight)];
        headview.delegate = self;
        headview.section = i;
        IndexingModel *model = [[SJSListManager sharedListManager]getBibleByIndex:i];
        if (model != nil) {
            [headview.backBtn setTitle:model.CH forState:UIControlStateNormal];
        }
        [_oldList addObject:headview];
    }
    //201-227
    for (int j = 201; j<=227; j++) {
        HeadView* headview = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, moreListSectionHeight)];
        headview.delegate = self;
        headview.section = j;
        IndexingModel *model = [[SJSListManager sharedListManager]getBibleByIndex:j];
        if (model != nil) {
            [headview.backBtn setTitle:model.CH forState:UIControlStateNormal];
        }
        [_newList addObject:headview];
    }
    _showList = [[NSMutableArray alloc]initWithArray:_oldList];
}
- (void)setNav {
    [self.SNavigationBar setTitle:@"目录索引"];
    [self.SNavigationBar setLeftBtn_parentName:@"读经"];
//    [self.SNavigationBar setLeftBtn_bacK];
    [self.SNavigationBar setRightBtnTitle:@"列表"];
}
- (void)SJSNavigationLeftAction:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:ShowTabbar object:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
//设置分段处理器
- (void)setSegmnet {
    // 分段选择器
    _segCon = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"旧约",@"新约", nil]];
    _segCon.frame = CGRectMake(0, navigationBarHight , viewWidth, segmentedHeight);
    // 设置默认值
    _segCon.selectedSegmentIndex = 0;
    _oldOrNew = 0;
    // 添加事件
    [_segCon addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_segCon];
}
- (void)segClick:(UISegmentedControl *)seg
{
    _oldOrNew = (int)seg.selectedSegmentIndex;
    if (_oldOrNew == 0) {
        for(int i = 0;i<[_oldList count];i++)
        {
            HeadView *head = [_oldList objectAtIndex:i];
            head.open = NO;
            [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
        }
        [_showList removeAllObjects];
        [_showList addObjectsFromArray:_oldList];
        [_listTable reloadData];
    }else{
        for(int i = 0;i<[_newList count];i++)
        {
            HeadView *head = [_newList objectAtIndex:i];
            head.open = NO;
            [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
        }
        [_showList removeAllObjects];
        [_showList addObjectsFromArray:_newList];
        [_listTable reloadData];
    }
}
- (void)setTable {
    _listTable = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBarHight+segmentedHeight, viewWidth, viewHeight-navigationBarHight-segmentedHeight)];
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_listTable];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_showList count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HeadView* headView = [_showList objectAtIndex:section];
    return headView.open?1:0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeadView* headView = [_showList objectAtIndex:indexPath.section];
    IndexingModel *model = [[SJSListManager sharedListManager]getBibleByIndex:(int)headView.section];
    int lines = [model.TOTALNUM intValue]/6+ (([model.TOTALNUM intValue]<6)?1:0);
    return headView.open?lines*50:0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return moreListSectionHeight;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [_showList objectAtIndex:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellName = @"cellName";
    SJSListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[SJSListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    HeadView* headView = [_showList objectAtIndex:indexPath.section];
    IndexingModel *model = [[SJSListManager sharedListManager]getBibleByIndex:(int)headView.section];
    [cell setCellByModel:model];
    cell.delegate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark  点击“卷章”,进入对应经文的阅读
/**
 @author Jesus       , 16-02-12 00:02:06
 
 @brief 点击“卷章”,进入对应经文的阅读
 
 @param index collection
 */
- (void)didSelectedCollectionIndex:(NSIndexPath *)indexPath {
        SJSReadNoteViewController * rnvc = [[SJSReadNoteViewController alloc]init];
        rnvc.readType = indexing;
        HeadView* headView = [_showList objectAtIndex:indexPath.section];
        rnvc.viewTitle = headView.backBtn.titleLabel.text;
        if (_oldOrNew ==0) {
            rnvc.dataType = old_cuv;
        }else{
            rnvc.dataType = new_cuv;
        }
        rnvc.sectionName = [NSString stringWithFormat:@"第%ld章",indexPath.row+1];
        rnvc.k_id = [NSString stringWithFormat:@"%lu",headView.section*1000+indexPath.row+1];
        [self.navigationController pushViewController:rnvc animated:NO];
}
#pragma mark - HeadViewdelegate
-(void)selectedWith:(HeadView *)view{
    if (view.open) {//之前处于打开状态
        if (_oldOrNew == 0) {
            for(int i = 0;i<[_oldList count];i++)
            {
                HeadView *head = [_oldList objectAtIndex:i];
                head.open = NO;
                [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
            }
            [_showList removeAllObjects];
            [_showList addObjectsFromArray:_oldList];
            [_listTable reloadData];
            return;
        }else{
            for(int i = 0;i<[_newList count];i++)
            {
                HeadView *head = [_newList objectAtIndex:i];
                head.open = NO;
                [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
            }
            [_showList removeAllObjects];
            [_showList addObjectsFromArray:_newList];
            [_listTable reloadData];
            return;
        }
     
    }
    _currentSection = view.section;
    [self reset];
    
}

//界面重置
- (void)reset
{
    if (_oldOrNew == 0) {
        for(int i = 0;i<[_oldList count];i++)
        {
            HeadView *head = [_oldList objectAtIndex:i];
            
            if(head.section == _currentSection)
            {
                head.open = YES;
                //只显示当前打开的组
                [_showList removeAllObjects];
                [_showList addObject:head];
                
            }else {
                head.open = NO;
            }
        }
    }else{
        for(int i = 0;i<[_newList count];i++)
        {
            HeadView *head = [_newList objectAtIndex:i];
            
            if(head.section == _currentSection)
            {
                head.open = YES;
                //只显示当前打开的组
                [_showList removeAllObjects];
                [_showList addObject:head];
                
            }else {
                head.open = NO;
            }
        }
    }
    //所有的组都打开
    //    [self.showHeaderArray removeAllObjects];
    //    [self.showHeaderArray addObjectsFromArray:headViewArray];
    [_listTable reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
