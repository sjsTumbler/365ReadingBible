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
#warning 当在矩阵模式下进入章列表时-- 对segmented进行操作会引发界面的混乱
@implementation SJSListViewController
{
    UISegmentedControl * _segCon;
    int                  _oldOrNew;//0-old,1-new
    NSMutableArray     * _oldList;
    NSMutableArray     * _oldRoot;
    NSMutableArray     * _newList;
    NSMutableArray     * _newRoot;
    NSMutableArray     * _showList;
    UITableView        * _listTable;
    UICollectionView   * _listCollection;
    NSInteger            _currentSection;
    int                  _tableOrCollection;//0-table,1-collection
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self setNav];
    [self setSegmnet];
    [self setTable];
    [self setCollection];
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
    _oldList = [[NSMutableArray alloc]init];
    _newList = [[NSMutableArray alloc]init];
    _oldRoot = [[NSMutableArray alloc]init];
    _newRoot = [[NSMutableArray alloc]init];
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
        [_oldRoot addObject:model.CH_Abbre];
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
        [_newRoot addObject:model.CH_Abbre];
    }
    if (_oldOrNew == 0) {
        _showList = [[NSMutableArray alloc]initWithArray:_oldList];
    }else if (_oldOrNew == 1){
        _showList = [[NSMutableArray alloc]initWithArray:_newList];
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
        _listCollection.hidden = NO;
//        [_listCollection reloadData];
        _listTable.hidden = YES;
        _tableOrCollection = 1;
        [self.SNavigationBar editRightBtnTitle:@"列表"];
        [[PublicFunctions sharedPublicFunctions]NSUserDefaults_SaveEditWithValue:@"1" Key:List_Table_Collection];
    }else if (_tableOrCollection == 1){//显示列表，隐藏矩阵
        _tableOrCollection = 0;
        [self.SNavigationBar editRightBtnTitle:@"矩阵"];
        _listCollection.hidden = YES;
        _listTable.hidden = NO;
//        [_listTable reloadData];
        [[PublicFunctions sharedPublicFunctions]NSUserDefaults_SaveEditWithValue:@"0" Key:List_Table_Collection];
    }
}
//设置分段处理器
- (void)setSegmnet {
    // 分段选择器
    _segCon = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"旧约",@"新约", nil]];
    _segCon.frame = CGRectMake(0, navigationBarHight , viewWidth, segmentedHeight);
    // 设置默认值
    _segCon.selectedSegmentIndex = _oldOrNew;
    // 添加事件
    [_segCon addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_segCon];
}
- (void)segClick:(UISegmentedControl *)seg
{
    _oldOrNew = (int)seg.selectedSegmentIndex;
    if (_oldOrNew == 0 ) {
        [[PublicFunctions sharedPublicFunctions]NSUserDefaults_SaveEditWithValue:@"0" Key:Old_New_Bible];
        for(int i = 0;i<[_oldList count];i++)
        {
            HeadView *head = [_oldList objectAtIndex:i];
            head.open = NO;
        }
        [_showList removeAllObjects];
        [_showList addObjectsFromArray:_oldList];
        [_listTable reloadData];
        
        
        [_listCollection reloadData];
    }else if (_oldOrNew == 1){
        [[PublicFunctions sharedPublicFunctions]NSUserDefaults_SaveEditWithValue:@"1" Key:Old_New_Bible];
        for(int i = 0;i<[_newList count];i++)
        {
            HeadView *head = [_newList objectAtIndex:i];
            head.open = NO;
        }
        [_showList removeAllObjects];
        [_showList addObjectsFromArray:_newList];
        [_listTable reloadData];
        
        
        [_listCollection reloadData];
    }
}
#pragma mark 设置列表
/**
 @author Jesus         , 16-02-14 11:02:43
 
 @brief 设置列表
 */
- (void)setTable {
    _listTable = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBarHight+segmentedHeight, viewWidth, viewHeight-navigationBarHight-segmentedHeight)];
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_listTable];
    if (_tableOrCollection == 0) {
        _listTable.hidden = NO;
        _listCollection.hidden = YES;
    }else if (_tableOrCollection == 1){
        _listTable.hidden = YES;
        _listCollection.hidden = NO;
    }
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
    int lines = [model.TOTALNUM intValue]/6+ (([model.TOTALNUM intValue]%6)?1:0);
    return headView.open?lines*listNumWH:0;
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
    if (_tableOrCollection == 1) {
        _listCollection.hidden = NO;
        _listTable.hidden = YES;
    }
    
    if (view.open) {//之前处于打开状态
        if (_oldOrNew == 0) {
            for(int i = 0;i<[_oldList count];i++)
            {
                HeadView *head = [_oldList objectAtIndex:i];
                head.open = NO;
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
#pragma mark  设置矩阵
/**
 @author Jesus        , 16-02-14 11:02:13
 
 @brief 设置矩阵
 */
- (void)setCollection {

    // 1.实例化布局模式
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置item大小
    [layout setItemSize:CGSizeMake(rootListWH, rootListWH)];
    [layout setMinimumLineSpacing:0.0];
    [layout setMinimumInteritemSpacing:0.0];
    // 3.设置布局方向(默认纵向)
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    // 4.实例化collectionView
    _listCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0,navigationBarHight+segmentedHeight ,viewWidth, rootListWH*8) collectionViewLayout:layout];
    _listCollection.backgroundColor = [UIColor clearColor];
    // 5.设置协议代理者
    _listCollection.delegate = self;
    _listCollection.dataSource = self;
    // 6.注册item
    [_listCollection registerClass:[SJSListRootCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    // 7.加入到view中
    [self.view addSubview:_listCollection];
    if (_tableOrCollection == 0) {
        _listTable.hidden = NO;
        _listCollection.hidden = YES;
    }else if (_tableOrCollection == 1){
        _listTable.hidden = YES;
        _listCollection.hidden = NO;
    }
}
// 设置有多少个分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// 设置一个分组中有多少item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _oldOrNew==0?38:26;
}

// item方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    SJSListRootCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    NSString * abbre = @"";
    if (_oldOrNew == 0) {
        abbre = [_oldRoot objectAtIndex:indexPath.row];
    }else if (_oldOrNew == 1) {
        abbre = [_newRoot objectAtIndex:indexPath.row];
    }
    cell.abbreLabel.text = abbre;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
#warning bug 1 maybe array out 
    NSLog(@"test bug -- indexPath.row = %ld    \n   showList.count = %ld",(long)indexPath.row,_showList.count);
    HeadView * headView = [_showList objectAtIndex:indexPath.row];
    _currentSection = headView.section;
    [self reset];
    _listTable.hidden = NO;
    _listCollection.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
