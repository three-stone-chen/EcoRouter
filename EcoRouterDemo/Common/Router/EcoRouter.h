//
//  EcoRouter.h
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/14.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EcoRouterConfigModel.h"
#import "EcoRouterUrlModel.h"
#import "EcoRouterExceptionProtocol.h"

/** 配置config */
typedef void(^EcoRouterConfigBlock)(EcoRouterConfigModel *config);

/** 回调 */
typedef void(^EcoRouterCallback)(id object);


@interface EcoRouter : NSObject

@property (nonatomic, assign) id<EcoRouterExceptionProtocol> exceptionDelegate;


/**单例方法
 *
 * @return EcoRouter对象
 */
+ (instancetype)shared;


/**配置EcoRouter
 *
 * @param config config对象
 */
+ (void)setupConfig:(EcoRouterConfigBlock)config;


/**远程调用打开地址调取页面
 *
 * @param url            地址
 * @param viewController 来源viewController
 * @param routerCallback 回调
 * @return YES/NO
 */
+ (BOOL)openUrl:(NSString *)url from:(UIViewController *)viewController completion:(EcoRouterCallback)routerCallback;


/**过滤器执行相关方法，并做相应的跳转
 *
 * @param targetName     过滤器类名前缀
 * @param actionName     过滤方法名
 * @param paramsDic      参数字典
 * @param viewController 来源viewController
 * @param routerCallback 回调
 * @return YES/NO
 */
+ (BOOL)performTarget:(NSString *)targetName action:(NSString *)actionName parameters:(NSDictionary *)paramsDic from:(UIViewController *)viewController completion:(EcoRouterCallback)routerCallback;

@end
