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
- (void)actionGo
{
    [EcoRouter performTarget:@"ModuleA"
                      action:@"A"
                  parameters:@{@"key1":@"1",@"key2":@"2",@"key3":@"3"}
                        from:self.navigationController
                  completion:^(id object) {
        
    }];
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
