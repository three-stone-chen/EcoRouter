//
//  TestAViewController.m
//  RouterTest
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "ModuleBViewController.h"

@implementation ModuleBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ModuleB_界面B";
    // Do any additional setup after loading the view.
}

- (void)setNavBarItem
{
    [self addRightItem];
}

///跳转
- (void)go
{
    NSDictionary *routerDic = [RouterTool getRouterPlistName:@"ModuleARouter"];
    [self.navigationController pushViewController:[RouterTool openUrl:routerDic[@"ModuleAViewController"]] animated:YES];
}

@end
