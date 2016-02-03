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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self setNav];
    [self setTable];
}
- (void)initData {
    self.dataArray = [[NSMutableArray alloc]init];
    self.dataArray =  [[ReadPlistManager sharedReadPlistManager]searchBibleByDataDic:_dataDic DBType:_dataType];
}
- (void)setNav {
    [self.SNavigationBar setTitle:_viewTitle];
    [self.SNavigationBar setLeftBtn_bacK];//setLeftBtn_parentName:@"读经"];
    [self.SNavigationBar setRightBtnImage:@"statistrics_nav"];
    //应该在选中时出现一个下拉的选择框:复制、note、收藏
}
- (void)SJSNavigationLeftAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)SJSNavigationRightAction:(UIButton *)sender {
    
}
- (void)setTable {
    _bibleTable = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBarHight, viewWidth, viewHeight-navigationBarHight-tabbarHeight)];
    _bibleTable.delegate = self;
    _bibleTable.dataSource = self;
    _bibleTable.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_bibleTable];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 21;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 21)];
    sectionTitle.text = [self.dataDic objectForKey:@"title"];
    sectionTitle.textAlignment = NSTextAlignmentLeft;
    sectionTitle.backgroundColor = [UIColor lightGrayColor];
    sectionTitle.font = [UIFont systemFontOfSize:15];
    return sectionTitle;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //动态的高度
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellName = @"cellName";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    NSString * bibleContent = @"";
    switch (_dataType) {
        case new_cuv:{
            new_cuvModel * model = [self.dataArray objectAtIndex:indexPath.row];
            bibleContent = model.Col003;
        }
            break;
        case new_ncv:{}
            break;
        case new_niv:{}
            break;
        case old_cuv:{
            old_cuvModel * model = [self.dataArray objectAtIndex:indexPath.row];
            bibleContent = model.Col003;
        }
            break;
        case old_ncv:{}
            break;
        case old_niv:{}
            break;
        default:
            break;
    }
    cell.textLabel.text = bibleContent;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
