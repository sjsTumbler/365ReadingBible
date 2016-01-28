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
    NSMutableArray * _daysArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self setNav];
    [self setTable];
}
- (void)initData {
    //需要在此前跳出设置读经开始日期的弹框，否则默认为1月1号
    _daysArray = [[NSMutableArray alloc]init];
    for(int i=1;i<=365;i++) {
        [_daysArray addObject:[NSString stringWithFormat:@"第%d天",i]];
    }
}
- (void)setNav {
    [self.SNavigationBar setTitle:@"读经"];
    [self.SNavigationBar setLeftBtnImage:@"list_nav"];
    [self.SNavigationBar setRightBtnImage:@"statistrics_nav"];
}
- (void)SJSNavigationLeftAction:(UIButton *)sender {
    SJSListViewController * LIST = [[SJSListViewController alloc]init];
    [self.navigationController pushViewController:LIST animated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:HideTabbar object:nil];
}
- (void)SJSNavigationRightAction:(UIButton *)sender {
    SJSStatistricsViewController *STA = [[SJSStatistricsViewController alloc]init];
    [self.navigationController pushViewController:STA animated:YES];
}
- (void)setTable {
    _daysListTable = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBarHight, viewWidth, viewHeight-navigationBarHight-tabbarHeight)];
    _daysListTable.delegate = self;
    _daysListTable.dataSource = self;
    [self.view addSubview:_daysListTable];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _daysArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellName = @"cellName";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text = [_daysArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",(long)indexPath.row+1);
    switch (indexPath.row) {
        case 0:{
            
        }
            break;
            
        default:
            break;
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
