//
//  ModuleBRootViewController.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "ModuleBRootViewController.h"

@interface ModuleBRootViewController ()

@end

@implementation ModuleBRootViewController

+ (void)load
{
    [RouterTool registerRouterListFromPlist:@"ModuleBRouter"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ModuleB_Root";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)go
{
    NSDictionary *routerDic = [RouterTool getRouterPlistName:@"ModuleBRouter"];
    [self.navigationController pushViewController:[RouterTool openUrl:routerDic[@"ModuleBViewController"]] animated:YES];
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
