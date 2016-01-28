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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNav];
}
- (void)setNav {
    [self.SNavigationBar setTitle:@"目录索引"];
    [self.SNavigationBar setLeftBtn_parentName:@"读经"];
//    [self.SNavigationBar setLeftBtn_bacK];
    [self.SNavigationBar setRightBtnTitle:@"列表"];
}
- (void)SJSNavigationLeftAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
