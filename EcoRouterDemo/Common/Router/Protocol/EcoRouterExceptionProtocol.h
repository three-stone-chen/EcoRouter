//
//  EcoRouterException.h
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/19.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EcoRouterExceptionProtocol <NSObject>

@optional

/**处理无法解析URL时的代理方法
 *
 * @param url 远程调用的URL
 */
- (void)routerCannotParseUrl:(NSString *)url;


/**处理无法匹配URLScheme的情况的代理方法
 *
 * @param scheme 远程调用的URL
 */
- (void)routerCannotMatchScheme:(NSString *)scheme;

/**处理无法匹配user&password，是否允许继续执行的代理方法
 
 * @param user      远程调用的用户名
 * @param password  远程调用的密码
 * @return          是否允许继续执行
 */
- (BOOL)routerCannotMatchUserOrPasswordWithUser:(NSString *)user
                                      andPassword:(NSString *)password;

/**处理无法映射到Class的情况的代理方法
 *
 * @param className 远程调用的类名
 */
- (void)routerCannotMapClass:(NSString *)className;


/**处理拒绝跳转的情况的代理方法
 *
 * @param className 远程调用的类名
 */
- (void)routerForbiddenOpenClass:(NSString *)className;

@end
