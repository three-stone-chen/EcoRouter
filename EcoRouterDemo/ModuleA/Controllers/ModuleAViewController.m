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
- (void)actionGo
{
    [EcoRouter performTarget:@"ModuleB"
                      action:@"B"
                  parameters:@{@"key":@"B界面"}
                        from:self.navigationController
                  completion:^(id object) {
                      
                  }];
}

@end
