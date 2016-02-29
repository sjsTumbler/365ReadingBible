//
//  SJSListShowViewController.m
//  Reading365
//
//  Created by SunJishuai on 16/2/20.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSListShowViewController.h"
//temp
#import "SJSReadNoteViewController.h"
@interface SJSListShowViewController ()
{
    NSMutableArray     * _showArray;//用于存储table的sections
    NSMutableArray     * _tableArray;
    NSMutableArray     * _collectionArray;
    UITableView        * _table;
    UICollectionView   * _collection;
    NSInteger            _currentSection;
    BOOL                 open;
}
@end

@implementation SJSListShowViewController

- (id)initWithFrame:(CGRect)frame Old_new:(int)old_new Table_collection:(int)table_collection{
    self.old_new = old_new;
    self.table_collection = table_collection;
    self = [super init];
    if (self) {
        self.view.frame = frame;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self setTable_collection];
    
}
#pragma mark  初始化界面数据
/**
 @author Jesus        , 16-02-21 21:02:20
 
 @brief 初始化界面数据
 */
- (void)initData {
    open = NO;
    _tableArray = [[NSMutableArray alloc]init];
    _collectionArray = [[NSMutableArray alloc]init];
    if (self.old_new == 0) {//old
        //101-139
        for (int i = 101; i<=139; i++) {
            HeadView* headview = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, moreListSectionHeight)];
            headview.delegate = self;
            headview.section = i;
            IndexingModel *model = [[SJSListManager sharedListManager]getBibleByIndex:i];
            if (model != nil) {
                [headview.backBtn setTitle:model.chinese forState:UIControlStateNormal];
            }
            [_tableArray addObject:headview];
#warning 崩溃 model为nil---- 数据库没有完整的拷贝到app的文件夹里-- 数据库拷贝问题需要谨慎一点啦
            [_collectionArray addObject:model.chineseAbbre];
        }
    }else if (self.old_new == 1){//new
        //201-227
        for (int j = 201; j<=227; j++) {
            HeadView* headview = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, moreListSectionHeight)];
            headview.delegate = self;
            headview.section = j;
            IndexingModel *model = [[SJSListManager sharedListManager]getBibleByIndex:j];
            if (model != nil) {
                [headview.backBtn setTitle:model.chinese forState:UIControlStateNormal];
            }
            [_tableArray addObject:headview];
            [_collectionArray addObject:model.chineseAbbre];
        }
    }
    _showArray = [[NSMutableArray alloc]initWithArray:_tableArray];
}
#pragma mark   搭建界面
/**
 @author Jesus       , 16-02-21 21:02:51
 
 @brief 搭建界面
 */
- (void)setTable_collection {
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-navigationBarHight-segmentHeight)];
    _table.delegate = self;
    _table.dataSource = self;
    _table.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_table];
    
    // 1.实例化布局模式
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置item大小
    [layout setItemSize:CGSizeMake(rootListWH, rootListWH)];
    [layout setMinimumLineSpacing:0.0];
    [layout setMinimumInteritemSpacing:0.0];
    // 3.设置布局方向(默认纵向)
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    // 4.实例化collectionView
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-navigationBarHight-segmentHeight) collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor clearColor];
    // 5.设置协议代理者
    _collection.delegate = self;
    _collection.dataSource = self;
    // 6.注册item
    [_collection registerClass:[SJSListRootCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    // 7.加入到view中
    [self.view addSubview:_collection];
    
    if (self.table_collection == 0) {
        _table.hidden = NO;
        _collection.hidden = YES;
    }else if (self.table_collection == 1) {
        _table.hidden = YES;
        _collection.hidden = NO;
    }
}

#pragma mark  tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _showArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HeadView* headView = [_showArray objectAtIndex:section];
    return headView.open?1:0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadView* headView  = [_showArray objectAtIndex:indexPath.section];
    IndexingModel *model = [[SJSListManager sharedListManager]getBibleByIndex:(int)headView.section];
    int lines = model.totalNumber/6+ ((model.totalNumber%6)?1:0);
    return headView.open?lines*listNumWH:0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return moreListSectionHeight;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [_showArray objectAtIndex:section];
 
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellName = @"cellName";
    SJSListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[SJSListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    HeadView* headView = [_showArray objectAtIndex:indexPath.section];
    IndexingModel *model = [[SJSListManager sharedListManager]getBibleByIndex:(int)headView.section];
    [cell setCellByModel:model];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark IndexingReadingDelegate
- (void)didSelectedCollectionIndex:(NSIndexPath *)indexPath {
    HeadView* headView = [_showArray objectAtIndex:indexPath.section];
    [self.delegate didSelectedShowListCollectionWithTitle:headView.backBtn.titleLabel.text DataType:self.old_new==0?old_cuv:new_ncv SectionName:[NSString stringWithFormat:@"第%ld章",indexPath.row+1] chapterNumber:[NSString stringWithFormat:@"%lu",headView.section*1000+indexPath.row+1]];
}
#pragma mark collectionVew的代理方法
// 设置有多少个分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// 设置一个分组中有多少item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.old_new==0?oldNumber-1:newNumber-1;
}

// item方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    SJSListRootCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    NSString * abbre = [_collectionArray objectAtIndex:indexPath.row];
    cell.abbreLabel.text = abbre;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HeadView * headView = [_showArray objectAtIndex:indexPath.row];
    _currentSection = headView.section;
    [self reset];
    _table.hidden = NO;
    _collection.hidden = YES;
    open = YES;
}
#pragma mark - HeadViewdelegate
-(void)selectedWith:(HeadView *)view{
    if (self.table_collection == 0) {
        _table.hidden = NO;
        _collection.hidden = YES;
    }else if (self.table_collection == 1) {
        _table.hidden = YES;
        _collection.hidden = NO;
    }
    if (view.open) {//之前处于打开状态
        open = NO;
        for(int i = 0;i<[_tableArray count];i++)
        {
            HeadView *head = [_tableArray objectAtIndex:i];
            head.open = NO;
        }
        [_showArray removeAllObjects];
        [_showArray addObjectsFromArray:_tableArray];
        [_table reloadData];
        return;
    }
    //能走到这一步说明是打开过程
    open = YES;
    _currentSection = view.section;
    [self reset];
    
}

//界面重置
- (void)reset
{
    for(int i = 0;i<[_tableArray count];i++)
    {
        HeadView *head = [_tableArray objectAtIndex:i];
        
        if(head.section == _currentSection)
        {
            head.open = YES;
            //只显示当前打开的组
            [_showArray removeAllObjects];
            [_showArray addObject:head];
            
        }else {
            head.open = NO;
        }
    }
    [_table reloadData];
}
#pragma mark 切换table和collection
/**
 @author Jesus         , 16-02-22 15:02:32
 
 @brief 切换table和collection
 
 @param table_collection
 */
- (void)setTableOrCollection:(int)table_collection{
    self.table_collection = table_collection;
    if(open == NO){//防止对打开状态的切换导致崩溃
        if (self.table_collection == 0) {
            _table.hidden = NO;
            _collection.hidden = YES;
        }else if (self.table_collection == 1) {
            _table.hidden = YES;
            _collection.hidden = NO;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
