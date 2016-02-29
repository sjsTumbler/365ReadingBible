//
//  SJSCollectionViewController.m
//  Reading365
//
//  Created by SunJishuai on 16/1/27.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSCollectionViewController.h"

@interface SJSCollectionViewController ()

@end

@implementation SJSCollectionViewController
{
    NSMutableArray * _collectionArray;
    NSMutableArray * _cellHeightArray;
    UITableView    * _collectionTable;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNav];
    [self setTable];
}
- (void)initData {
    if (_collectionArray == nil) {
        _collectionArray = [[NSMutableArray alloc]initWithArray:[[SJSCollectionManager sharedCollectionManager]getAllCollectionBible]];
    }else{
        [_collectionArray removeAllObjects];
        [_collectionArray addObjectsFromArray:[[SJSCollectionManager sharedCollectionManager]getAllCollectionBible]];
    }
    if (_cellHeightArray == nil) {
        _cellHeightArray = [[NSMutableArray alloc]initWithArray:[[SJSCollectionManager sharedCollectionManager]getHeightOfCell:_collectionArray]];
    }else{
        [_cellHeightArray removeAllObjects];
        [_cellHeightArray addObjectsFromArray:[[SJSCollectionManager sharedCollectionManager]getHeightOfCell:_collectionArray]];
    }
    [_collectionTable reloadData];
}

- (void)setNav {
    [self.SNavigationBar setTitle:@"收藏"];
//    [self.SNavigationBar setLeftBtn_bacK];
}
- (void)SJSNavigationLeftAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
//- (void)SJSNavigationRightAction:(UIButton *)sender {
//    CGPoint point = CGPointMake(1, 0);
//    [SJSReadNotePopView configCustomPopViewWithFrame:CGRectMake(viewWidth-edages-130, navigationBarHight, 130, 200) imagesArr:@[@"saoyisao.png",@"jiahaoyou.png",@"taolun.png",@"diannao.png",@"diannao.png",@"shouqian.png"] dataSourceArr:@[@"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱"] anchorPoint:point seletedRowForIndex:^(NSInteger index) {
//        NSLog(@"%ld", index + 1);
//    } animation:YES timeForCome:0.3 timeForGo:0.3];
//}
- (void)setTable {
    _collectionTable = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBarHight, viewWidth, viewHeight-navigationBarHight)];
    _collectionTable.delegate = self;
    _collectionTable.dataSource = self;
    _collectionTable.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight/2)];
    [self.view addSubview:_collectionTable];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _collectionArray.count ;
    }else{
        return 0;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return sectionHeight;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(edages, 0, viewWidth-edages,sectionHeight)];
    if (section == 0) {
        sectionTitle.text = @"收藏";
    }else {
        sectionTitle.text = @"笔记";
    }
    sectionTitle.textAlignment = NSTextAlignmentLeft;
    sectionTitle.font = [UIFont systemFontOfSize:15];
    UIView * sectionView = [[UIView alloc]init];
    sectionView.backgroundColor = iColorWithHex(sectionColor);
    [sectionView addSubview:sectionTitle];
    return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [[_cellHeightArray objectAtIndex:indexPath.row]floatValue];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellName = @"saveCell";
        SJSCollectionTableViewCell * saveCell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (saveCell == nil) {
            saveCell = [[SJSCollectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        CommonModel * model = [_collectionArray objectAtIndex:indexPath.row];
        saveCell.chapterSectionLabel.text = [NSString stringWithFormat:@"%@ %@",model.abbre,model.chapterSection];
        saveCell.timeLabel.text = [[PublicFunctions sharedPublicFunctions]dateTimeToString:model.dateTime Type:1];
        saveCell.contentLabel.text = model.content;
        [saveCell frameToFitSize:[[_cellHeightArray objectAtIndex:indexPath.row]floatValue]-labelHeight];
        return saveCell;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//让tableView可以进入编辑模式
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [_collectionTable setEditing:editing animated:YES];
}

//设置删除操作
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        //数据库删除
        [[SJSCollectionManager sharedCollectionManager]deleteCollectionModelByCommonModel:[_collectionArray objectAtIndex:indexPath.row]];
        //删除数据源中对应数据
        [_collectionArray removeObjectAtIndex:indexPath.row];
        [_cellHeightArray removeObjectAtIndex:indexPath.row];
        //执行删除动画
        [_collectionTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

//添加或删除操作确定
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
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
