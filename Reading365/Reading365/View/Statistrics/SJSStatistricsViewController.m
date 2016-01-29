//
//  SJSStatistricsViewController.m
//  Reading365
//
//  Created by SunJishuai on 16/1/28.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//  统计

#import "SJSStatistricsViewController.h"

@interface SJSStatistricsViewController ()

@end

@implementation SJSStatistricsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNav];
}
- (void)setNav {
    [self.SNavigationBar setTitle:@"统计"];
    [self.SNavigationBar setLeftBtn_parentName:@"读经"];
}
- (void)SJSNavigationLeftAction:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:ShowTabbar object:nil];
    [self.navigationController popViewControllerAnimated:NO];
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
