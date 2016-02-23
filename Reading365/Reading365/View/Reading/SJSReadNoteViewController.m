//
//  SJSReadNoteViewController.m
//  Reading365
//
//  Created by SunJishuai on 16/2/3.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSReadNoteViewController.h"

@interface SJSReadNoteViewController ()

@end

@implementation SJSReadNoteViewController
{
    UITableView * _bibleTable;
    NSMutableArray * _cellHeightArray;
//    SJSReadNoteTableViewCell * _readNoteCell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self setNav];
    [self setTable];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //解决cell还原问题
    NSArray *cells = [_bibleTable visibleCells];
    for (SJSReadNoteTableViewCell * cell in cells) {
        [cell hideMenuView:YES Animated:YES];
    }
}
- (void)initData {
    self.dataArray = [[NSMutableArray alloc]init];
    if (self.readType == 0) {
        self.dataArray =  [[SJSReadNoteManager sharedReadNoteManager]searchBibleByDataDic:_dataDic DBType:_dataType];
        
    }else{
        self.dataArray = [[SJSReadNoteManager sharedReadNoteManager]searchBibleByk_id:self.k_id DBType:self.dataType];
    }
    _cellHeightArray = [[NSMutableArray alloc]initWithArray:[[SJSReadNoteManager sharedReadNoteManager]getAutoCellHeightByModels:self.dataArray Type:_dataType]];
}
- (void)setNav {
    [self.SNavigationBar setTitle:_viewTitle];
    [self.SNavigationBar setLeftBtn_bacK];//setLeftBtn_parentName:@"读经"];
    [self.SNavigationBar setRightBtnImage:@"statistrics_nav"];
    //应该在选中时出现一个下拉的选择框:复制、note、收藏
}
- (void)SJSNavigationLeftAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:NO];
    if (self.readType == 0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:ShowTabbar object:nil];
    }
}
- (void)SJSNavigationRightAction:(UIButton *)sender {
    CGPoint point = CGPointMake(1, 0);
    [SJSReadNotePopView configCustomPopViewWithFrame:CGRectMake(viewWidth-edages-130, navigationBarHight, 130, 200) imagesArr:@[@"saoyisao.png",@"jiahaoyou.png",@"taolun.png",@"diannao.png",@"diannao.png",@"shouqian.png"] dataSourceArr:@[@"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱"] anchorPoint:point seletedRowForIndex:^(NSInteger index) {
        NSLog(@"%ld", index + 1);
    } animation:YES timeForCome:0.3 timeForGo:0.3];
}
- (void)setTable {
    _bibleTable = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBarHight, viewWidth, viewHeight-navigationBarHight)];
    _bibleTable.delegate = self;
    _bibleTable.dataSource = self;
    _bibleTable.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight/2)];
    [self.view addSubview:_bibleTable];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return sectionHeight;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(edages, 0, viewWidth-edages,sectionHeight)];
    if (self.readType == 0) {
        sectionTitle.text = [self.dataDic objectForKey:@"title"];
    }else {
        sectionTitle.text = self.sectionName;
    }
    sectionTitle.textAlignment = NSTextAlignmentLeft;
    sectionTitle.font = [UIFont systemFontOfSize:15];
    UIView * sectionView = [[UIView alloc]init];
    sectionView.backgroundColor = iColorWithHex(sectionColor);
    [sectionView addSubview:sectionTitle];
    return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[_cellHeightArray objectAtIndex:indexPath.row]floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"contentCell";
    SJSReadNoteTableViewCell *cell = (SJSReadNoteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SJSReadNoteTableViewCell" owner:self options:nil]lastObject];
        cell.backgroundColor = [UIColor whiteColor];
    }
    NSString * bibleContent = @"";
    switch (_dataType) {
        case new_cuv:{
            new_cuvModel * model = [self.dataArray objectAtIndex:indexPath.row];
            bibleContent = [NSString stringWithFormat:@"%@:%@ %@",model.col_004,model.col_005,model.Col003];
        }
            break;
        case new_ncv:{
            new_ncvModel * model = [self.dataArray objectAtIndex:indexPath.row];
            bibleContent = [NSString stringWithFormat:@"%@:%@ %@",model.col_004,model.col_005,model.Col003];
        }
            break;
        case new_niv:{
            new_nivModel * model = [self.dataArray objectAtIndex:indexPath.row];
            bibleContent = [NSString stringWithFormat:@"%@:%@ %@",model.col_004,model.col_005,model.Col003];
        }
            break;
        case old_cuv:{
            old_cuvModel * model = [self.dataArray objectAtIndex:indexPath.row];
            bibleContent = [NSString stringWithFormat:@"%@:%@ %@",model.col_004,model.col_005,model.Col003];
        }
            break;
        case old_ncv:{
            old_ncvModel * model = [self.dataArray objectAtIndex:indexPath.row];
            bibleContent = [NSString stringWithFormat:@"%@:%@ %@",model.col_004,model.col_005,model.Col003];
        }
            break;
        case old_niv:{
            old_nivModel * model = [self.dataArray objectAtIndex:indexPath.row];
            bibleContent = [NSString stringWithFormat:@"%@:%@ %@",model.col_004,model.col_005,model.Col003];
        }
            break;
        default:
            break;
    }
    cell.delegate = self;//滑动的代理
    cell.iContentLabel.text = bibleContent;
    [cell frameToFitSize:[[_cellHeightArray objectAtIndex:indexPath.row]floatValue]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma  mark SJSReadNoteTableViewCellDelegate 滑动收藏笔记
/**
 @author SunJishuai,
 
 @brief  SJSReadNoteTableViewCellDelegate
 
 @param aSender 滑动手势
 */
-(void)didCellWillShow:(id)aSender{
    //解决cell还原问题-- 实现单次只对一个cell操作
    NSArray *cells = [_bibleTable visibleCells];
    for (SJSReadNoteTableViewCell * cell in cells) {
        [cell hideMenuView:YES Animated:NO];
    }
//    _readNoteCell = aSender;
    self.canCustomEdit = YES;
}

-(void)didCellWillHide:(id)aSender{
//    _readNoteCell = nil;
    self.canCustomEdit = NO;
}

-(void)didCellHided:(id)aSender{
//    _readNoteCell = nil;
    self.canCustomEdit = NO;
}

-(void)didCellShowed:(id)aSender{
//    _readNoteCell = aSender;
    self.canCustomEdit = YES;
}
#pragma mark 收藏
/**
 @author SunJishuai , 15-07-25 14:07:54
 
 @brief  收藏
 
 @param aSender
 */
-(void)didCellClickedSaveButton:(SJSReadNoteTableViewCell*)aSender{
    [aSender hideMenuView:YES Animated:YES];
    NSLog(@"收藏");
//    self.indexPath = [_bibleTable indexPathForCell:aSender];
    self.canCustomEdit = NO;
}

#pragma mark 点击笔记
-(void)didCellClickedNoteButton:(SJSReadNoteTableViewCell*)aSender{
    NSLog(@"笔记");
    //自动恢复
    [aSender hideMenuView:YES Animated:YES];
//    NSIndexPath *indexPath = [_listTable indexPathForCell:aSender];
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
