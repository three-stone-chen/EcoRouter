//
//  EcoBaseRouterFilter.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/19.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "EcoBaseRouterFilter.h"
#import "UIViewController+Router.h"

@implementation EcoBaseRouterFilter

#pragma mark - 过滤器
- (id)checkOpenClass:(NSString *)className  actionName:(NSString *)actionName params:(NSDictionary *)paramsDic from:(UIViewController *)viewController
{
    SEL action = NSSelectorFromString(actionName);

    if ([self respondsToSelector:action])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        BOOL result = [self performSelector:action];
#pragma clang diagnostic pop
        if (result)
        {
            [self openClass:className params:(NSDictionary *)paramsDic from:viewController];
        }
        return @(result);
    }
    else
    {
        [self openClass:className params:(NSDictionary *)paramsDic from:viewController];
        return @(YES);
    }
    
    return @(NO);
}

#pragma mark 跳转
- (void)openClass:(NSString *)className params:(NSDictionary *)paramsDic from:(UIViewController *)viewController
{
    UIViewController *routerViewController = [[NSClassFromString(className) alloc] init];
    routerViewController.paramDic = paramsDic;
    
    if ([routerViewController isKindOfClass:[UIViewController class]])
    {
        if ([viewController isKindOfClass:[UINavigationController class]])
        {
            [(UINavigationController *)viewController pushViewController:routerViewController animated:YES];
        }
        else
        {
            UINavigationController *routerNav = [[UINavigationController alloc] initWithRootViewController:routerViewController];
            [viewController presentViewController:routerNav animated:YES completion:^{
                
            }];
        }
    }
}


@end
