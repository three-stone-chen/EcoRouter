//
//  EcoRouterConfigModel.h
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/18.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EcoRouterConfigModel : NSObject

/** 用于验证的URL的Scheme */
@property (nonatomic, copy) NSString *urlScheme;

/** 用于验证的URL的User */
@property (nonatomic, copy) NSString *user;

/** 用于验证的URL的Password */
@property (nonatomic, copy) NSString *password;

/** APP的URL路由映射表的路径 */
@property (nonatomic, copy) NSString *urlRouteMapFilePath;

/** 是否跳过URL验证 */
@property (nonatomic, assign) BOOL urlVerifySkip;

@end
