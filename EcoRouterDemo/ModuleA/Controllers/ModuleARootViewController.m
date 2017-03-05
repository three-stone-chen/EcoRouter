//
//  ModuleARootViewController.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "ModuleARootViewController.h"

@interface ModuleARootViewController ()

@end

@implementation ModuleARootViewController

+ (void)load
{
    [RouterTool registerRouterListFromPlist:@"ModuleARouter"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ModuleA_Root";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///跳转
- (void)go
{
    NSDictionary *routerDic = [RouterTool getRouterPlistName:@"ModuleARouter"];
    [self.navigationController pushViewController:[RouterTool openUrl:routerDic[@"ModuleAViewController"]] animated:YES];
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
