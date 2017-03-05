//
//  RouterTool.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "RouterTool.h"
#import "EcoRouter.h"
#import "BaseViewController.h"

@implementation RouterTool

///获取路由表
+ (NSDictionary *)getRouterPlistName:(NSString *)fileName
{
    fileName = (fileName && ![fileName isKindOfClass:[NSNull class]]) ? fileName : @"";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSDictionary *routerDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return routerDic;
}

///注册Router表
+ (void)registerRouterListFromPlist:(NSString *)fileName
{
    NSDictionary *routerDic = [self getRouterPlistName:fileName];
    
    for (NSString *key in routerDic.allKeys)
    {
        [EcoRouter registerURLPattern:routerDic[key] toObjectHandler:^id(NSDictionary *routerParameters) {
            
            UIViewController *viewController = [[NSClassFromString(key) alloc] init];
            if ([viewController isKindOfClass:[UIViewController class]])
            {
                BaseViewController *baseViewController = (BaseViewController *)viewController;
                [baseViewController setParamDic:routerParameters];
                return baseViewController;
            }
            return viewController;
            
        }];
    }
}


///打开RouterLink
+ (UIViewController *)openUrl:(NSString *)url
{
   return [EcoRouter objectForURL:url];
}

///打开RouterLink
+ (UIViewController *)openUrl:(NSString *)url withUserInfo:(NSDictionary *)userInfo
{
    return [EcoRouter objectForURL:url withUserInfo:userInfo];
}


@end
