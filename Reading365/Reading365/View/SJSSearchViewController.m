//
//  SJSSearchViewController.m
//  Reading365
//
//  Created by SunJishuai on 16/1/27.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSSearchViewController.h"
#import "searchSelectedView.h"
@interface SJSSearchViewController ()

@end

@implementation SJSSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.SNavigationBar setTitle:@"搜索"];
    
    searchSelectedView *selectedView = [[searchSelectedView alloc]initWithFrame:CGRectMake(0, navigationBarHight, viewWidth,50) Title:@"搜索范围" segArray:@[@"整本圣经",@"新约",@"旧约",@"律法书",@"历史书",@"诗歌 智慧书",@"先知书",@"四福音",@"使徒行传",@"书信",@"约翰的启示"]];
    [self.view addSubview:selectedView];
//    self.view.width
    
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
