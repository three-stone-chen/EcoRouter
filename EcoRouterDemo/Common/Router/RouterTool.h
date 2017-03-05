//
//  RouterTool.h
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RouterTool : NSObject

/**
 *  获取路由表
 *
 *  @param fileName plist文件名字
 *
 *  @return 路由表
 */
+ (NSDictionary *)getRouterPlistName:(NSString *)fileName;

/**
 *  通过Plist批量注册RouterUrl
 *
 *  @param fileName plist文件名字
 */

+ (void)registerRouterListFromPlist:(NSString *)fileName;

/**
 *  打开RouterLink
 *
 *  @param url 路由地址
 *
 *  @return UIViewController
 */

+ (UIViewController *)openUrl:(NSString *)url;

/**
 *  打开RouterLink
 *
 *  @param url      路由地址
 *  @param userInfo 参数
 *
 *  @return UIViewController
 */

+ (UIViewController *)openUrl:(NSString *)url withUserInfo:(NSDictionary *)userInfo;

@end
