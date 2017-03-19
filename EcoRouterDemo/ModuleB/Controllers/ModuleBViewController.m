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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        EcoRouterCallback callback =  self.paramDic[@"callback"];
        if (callback)
        {
            callback(@"123456");
        }
    });

    // Do any additional setup after loading the view.
}

- (void)setNavBarItem
{
    [self addRightItem];
}

///跳转
- (void)actionGo
{
    [self performTarget:@"ModuleA"
                      action:@"A"
                  parameters:@{@"key":@"界面A"}
                        from:self.navigationController
                  completion:^(id object) {
                      
                  }];
}

@end
