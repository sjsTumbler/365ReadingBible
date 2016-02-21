//
//  SJSListShowViewController.m
//  Reading365
//
//  Created by SunJishuai on 16/2/20.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSListShowViewController.h"

@interface SJSListShowViewController ()
{
    NSMutableArray     * _showArray;//用于存储table的sections
    NSMutableArray     * _tableArray;
    NSMutableArray     * _collectionArray;
    UITableView        * _table;
    UICollectionView   * _collection;
    NSInteger            _currentSection;
}
@end

@implementation SJSListShowViewController

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
                [headview.backBtn setTitle:model.CH forState:UIControlStateNormal];
            }
            [_tableArray addObject:headview];
            [_collectionArray addObject:model.CH_Abbre];
        }
    }else if (self.old_new == 1){//new
        //201-227
        for (int j = 201; j<=227; j++) {
            HeadView* headview = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, moreListSectionHeight)];
            headview.delegate = self;
            headview.section = j;
            IndexingModel *model = [[SJSListManager sharedListManager]getBibleByIndex:j];
            if (model != nil) {
                [headview.backBtn setTitle:model.CH forState:UIControlStateNormal];
            }
            [_tableArray addObject:headview];
            [_collectionArray addObject:model.CH_Abbre];
        }
    }
    if (self.table_collection == 0) {//table
        _showArray = [[NSMutableArray alloc]initWithArray:_tableArray];
    }else if (self.table_collection == 1) {
        _showArray = [[NSMutableArray alloc]initWithArray:_collectionArray];
    }
}
#pragma mark   搭建界面
/**
 @author Jesus       , 16-02-21 21:02:51
 
 @brief 搭建界面
 */
- (void)setTable_collection {
    _table = [[UITableView alloc]initWithFrame:self.view.bounds];
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
    _collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
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
    int lines = [model.TOTALNUM intValue]/6+ (([model.TOTALNUM intValue]%6)?1:0);
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



#warning 此处需要代理 -- 把此代理方法传递给父视图
//- (void)didSelectedCollectionIndex:(NSIndexPath *)indexPath {
//    SJSReadNoteViewController * rnvc = [[SJSReadNoteViewController alloc]init];
//    rnvc.readType = indexing;
//    HeadView* headView = nil;
//    if (_oldOrNew == 0) {
//        headView = [_oldList objectAtIndex:indexPath.section];
//    }else{
//        headView = [_newList objectAtIndex:indexPath.section];
//    }
//    
//    //        HeadView* headView = [_showList objectAtIndex:indexPath.section];
//    rnvc.viewTitle = headView.backBtn.titleLabel.text;
//    if (_oldOrNew ==0) {
//        rnvc.dataType = old_cuv;
//    }else{
//        rnvc.dataType = new_cuv;
//    }
//    rnvc.sectionName = [NSString stringWithFormat:@"第%ld章",indexPath.row+1];
//    rnvc.k_id = [NSString stringWithFormat:@"%lu",headView.section*1000+indexPath.row+1];
//    [self.navigationController pushViewController:rnvc animated:NO];
//}
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
}
#pragma mark - HeadViewdelegate
-(void)selectedWith:(HeadView *)view{
    if (self.table_collection == 1) {
        _collection.hidden = NO;
        _table.hidden = YES;
    }
    
    if (view.open) {//之前处于打开状态
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
            [_tableArray removeAllObjects];
            [_tableArray addObject:head];
            
        }else {
            head.open = NO;
        }
    }
    [_table reloadData];
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
