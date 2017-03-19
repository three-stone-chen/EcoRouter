//
//  EcoBaseRouterFilter.h
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/19.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EcoBaseRouterFilter : NSObject

/**过滤并打开相关页面
 *
 * @param className      过滤器类名前缀
 * @param actionName     过滤方法名
 * @param paramsDic      参数字典
 * @param viewController 来源viewController
 * @return   返回对象：@(YES)/@(NO)
*/
- (id)checkOpenClass:(NSString *)className  actionName:(NSString *)actionName params:(NSDictionary *)paramsDic from:(UIViewController *)viewController;

@end
