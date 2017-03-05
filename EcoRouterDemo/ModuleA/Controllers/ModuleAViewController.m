//
//  TestAViewController.m
//  RouterTest
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "ModuleAViewController.h"

@implementation ModuleAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ModuleA_界面A";
    // Do any additional setup after loading the view.
}

- (void)setNavBarItem
{
    [self addRightItem];
}

///跳转
- (void)go
{
    NSDictionary *routerDic = [RouterTool getRouterPlistName:@"ModuleBRouter"];
    [self.navigationController pushViewController:[RouterTool openUrl:routerDic[@"ModuleBViewController"]] animated:YES];
}

@end
