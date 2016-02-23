//
//  SJSReadingViewController.m
//  365_readingBible
//
//  Created by SunJishuai on 16/1/23.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSReadingViewController.h"

@interface SJSReadingViewController ()

@end

@implementation SJSReadingViewController
{
    UITableView    * _daysListTable;
    NSInteger        _currentSection;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(initData) name:RefreshStatus object:nil];
    [self initData];
    [self setNav];
    [self setTable];
}
- (void)initData {
    //需要在此前跳出设置读经开始日期的弹框，否则默认为1月1号
    if (self.headViewArray == nil){
        self.headViewArray = [[NSMutableArray alloc]init];
    }else{
        [self.headViewArray removeAllObjects];
    }
    
    //      先判断是否已读，已读则不显示
    NSDictionary * statusDic = [[ReadPlistManager sharedReadPlistManager]getSatusOfBible];
    // 使用plist文件解决此问题，进入程序先判断是否有plist文件，没有则生成一个全部未读的365表，每次对经文阅读状态点击，都会在后台判断更改当天的阅读状态，此处加载数据之前先把plist文件读出来，一一对应，以解决过多数据库打开操作引起的异常现象
    for(int i = 1;i<= 278 ;i++)
    {
        if ([[statusDic objectForKey:[NSString stringWithFormat:@"第%d天",i]]intValue] == 1) {
            continue;
        }
        HeadView* headview = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, moreListSectionHeight)];
        headview.delegate = self;
        headview.section = i;
        [headview.backBtn setTitle:[NSString stringWithFormat:@"第%d天",i] forState:UIControlStateNormal];
        [self.headViewArray addObject:headview];
    }
    if (self.showHeaderArray == nil) {
        self.showHeaderArray = [[NSMutableArray alloc]initWithArray:self.headViewArray];
    }else{
        [self.headViewArray removeAllObjects];
        self.headViewArray = [NSMutableArray arrayWithArray:self.headViewArray];
    }
    self.dayData = [[NSArray alloc]init];
}
- (void)setNav {
    [self.SNavigationBar setTitle:@"读经"];
    [self.SNavigationBar setLeftBtnImage:@"list_nav"];
    [self.SNavigationBar setRightBtnImage:@"statistrics_nav"];
}
- (void)SJSNavigationLeftAction:(UIButton *)sender {
    SJSListViewController * LIST = [[SJSListViewController alloc]init];
    [self.navigationController pushViewController:LIST animated:NO];
    [[NSNotificationCenter defaultCenter]postNotificationName:HideTabbar object:nil];
}
- (void)SJSNavigationRightAction:(UIButton *)sender {
    SJSStatistricsViewController *STA = [[SJSStatistricsViewController alloc]init];
    [self.navigationController pushViewController:STA animated:NO];
    [[NSNotificationCenter defaultCenter]postNotificationName:HideTabbar object:nil];
}
- (void)setTable {
    _daysListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBarHight, viewWidth, viewHeight-navigationBarHight-tabbarHeight)];
    _daysListTable.delegate = self;
    _daysListTable.dataSource = self;
    _daysListTable.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_daysListTable];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.showHeaderArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HeadView* headView = [self.showHeaderArray objectAtIndex:section];
    return headView.open?4:0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeadView* headView = [self.showHeaderArray objectAtIndex:indexPath.section];
    
    return headView.open?cellHeight:0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return moreListSectionHeight;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.showHeaderArray objectAtIndex:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellName = @"cellName";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        UIButton * selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(viewWidth-44, 0, 44, 44);
        [selectButton setImage:[UIImage imageNamed:@"select_mark_nor"] forState:UIControlStateNormal];
        [selectButton setImage:[UIImage imageNamed:@"select_mark_sel"] forState:UIControlStateSelected];
        [selectButton addTarget:self action:@selector(readMaskButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:selectButton];
    }
    for (UIView * view in cell.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            int sectionNow = [[[self.dayData firstObject]objectForKey:@"onlyTag"]intValue]/1000;
            view.tag = sectionNow*1000 + indexPath.row+1;
            if ([[[ReadPlistManager sharedReadPlistManager]getStatusOfBible:view.tag ] isEqualToString:@"0"]) {
                ((UIButton *)view).selected = NO;
            }else {
                ((UIButton *)view).selected = YES;
            }
        }
    }
    
    
    NSString * bibleTitle = [[ReadPlistManager sharedReadPlistManager]getTitleByData:self.dayData Index:indexPath.row];
    switch (indexPath.row) {
        case 0:
            bibleTitle = [NSString stringWithFormat:@"旧约:%@",bibleTitle];
            break;
        case 1:
            bibleTitle = [NSString stringWithFormat:@"新约:%@",bibleTitle];
            break;
        case 2:
            bibleTitle = [NSString stringWithFormat:@"诗篇:%@",bibleTitle];
            break;
        case 3:
            bibleTitle = [NSString stringWithFormat:@"箴言:%@",bibleTitle];
            break;
        default:
            break;
    }
    cell.textLabel.text = bibleTitle;
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SJSReadNoteViewController * readNote = [[SJSReadNoteViewController alloc]init];
//    readNote.viewTitle = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    readNote.readType = plan;
    readNote.dataDic = [self.dayData objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:{
        readNote.dataType = old_cuv;
            readNote.viewTitle = @"旧约";
        }
            break;
        case 1:{
            readNote.dataType = new_cuv;
            readNote.viewTitle = @"新约";
        }
            break;
        case 2:{
        readNote.dataType = old_cuv;
            readNote.viewTitle = @"诗篇";
        }
            break;
        case 3:{
            readNote.dataType = old_cuv;
            readNote.viewTitle = @"箴言";
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:readNote animated:NO];
    [[NSNotificationCenter defaultCenter]postNotificationName:HideTabbar object:nil];
}
#pragma mark - HeadViewdelegate
-(void)selectedWith:(HeadView *)view{
    if (view.open) {//之前处于打开状态
        for(int i = 0;i<[self.headViewArray count];i++)
        {
            HeadView *head = [self.headViewArray objectAtIndex:i];
            head.open = NO;
        }
        [self.showHeaderArray removeAllObjects];
        [self.showHeaderArray addObjectsFromArray:self.headViewArray];
        [_daysListTable reloadData];
        return;
    }
    _currentSection = view.section;
    self.dayData = [[ReadPlistManager sharedReadPlistManager]readArrayDataOnDay:view.section-1];
    [self reset];
    
}

//界面重置
- (void)reset
{
    for(int i = 0;i<[self.headViewArray count];i++)
    {
        HeadView *head = [self.headViewArray objectAtIndex:i];
        
        if(head.section == _currentSection)
        {
            head.open = YES;
            //只显示当前打开的组
            [self.showHeaderArray removeAllObjects];
            [self.showHeaderArray addObject:head];
            
        }else {
            head.open = NO;
        }
    }
    //所有的组都打开
    //    [self.showHeaderArray removeAllObjects];
    //    [self.showHeaderArray addObjectsFromArray:headViewArray];
    [_daysListTable reloadData];
}
#pragma mark  标记为已读
/**
 @author Jesus   , 16-02-08 22:02:00
 
 @brief 标记为已读
 
 @param markButton 按钮
 */
- (void)readMaskButton:(UIButton *)markButton {
    if (markButton.selected) {
        markButton.selected = NO;
        [[ReadPlistManager sharedReadPlistManager]setStatusOfBibleBy:markButton.tag isRead:@"0"];
    }else {
        markButton.selected = YES;
        [[ReadPlistManager sharedReadPlistManager]setStatusOfBibleBy:markButton.tag isRead:@"1"];
    }
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
