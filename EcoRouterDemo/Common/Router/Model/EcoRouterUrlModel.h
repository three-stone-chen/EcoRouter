//
//  EcoRouterUrlModel.h
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/18.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EcoRouterUrlModel : NSObject

/** URL的Scheme */
@property (nonatomic, copy) NSString *scheme;

/** URL的访问user */
@property (nonatomic, copy) NSString *user;

/** URL的访问password */
@property (nonatomic, copy) NSString *password;

/** URL的过滤类名（path第一个） */
@property (nonatomic, copy) NSString *target;

/** URL的过滤方法名（path最后一个） */
@property (nonatomic, copy) NSString *action;

/** URL的参数 */
@property (nonatomic, strong) NSDictionary *paramsDic;


/**解析URL，返回一个url对象
 *
 * @param   urlString   url字符串
 * @return  url对象
 */
+ (instancetype)parseObjectWithURL:(NSString *)urlString;

@end
