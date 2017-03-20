//
//  EcoRouter.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/14.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#define FILTER_SUFFIX   @"Filter"
#define ACTION_SUFFIX   @"Action"

#define URL_ERROR       @"Url解析错误"
#define SCHEME_ERROR    @"错误调用"
#define VERITY_ERROR    @"非法调用"
#define NOTFOUND_ERROR  @"未找到相关页面"
#define FORBIDDEN_ERROR @"跳转被拒绝"

#import "EcoRouter.h"
#import "NSObject+PerformSelector.h"

@interface EcoRouter ()

/** 保存Target实例，在频繁调用时保存。 */
@property (nonatomic, strong) NSMutableDictionary *cachedTarget;

/** EcoRouter的参数配置数据对象 */
@property (nonatomic, strong) EcoRouterConfigModel *routerConfig;

/** APP的映射表 */
@property (nonatomic, strong, readonly) NSDictionary *urlMapDic;

@end

@implementation EcoRouter

#pragma mark - public methods

#pragma mark - 获取单例
+ (instancetype)shared
{
    static EcoRouter *ecoRouter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ecoRouter = [[EcoRouter alloc] init];
    });
    return ecoRouter;
}

#pragma mark - 配置EcoRouter

+ (void)setupConfig:(EcoRouterConfigBlock)routerConfig
{
    return [[self shared] setupConfig:routerConfig];
}


- (void)setupConfig:(EcoRouterConfigBlock)config
{
    !config ? nil : config(self.routerConfig);
    _urlMapDic = [NSDictionary dictionaryWithContentsOfFile:self.routerConfig.urlRouteMapFilePath];
    NSLog(@"_urlMapDic====%@",_urlMapDic);
}

- (EcoRouterConfigModel *)routerConfig
{
    if (!_routerConfig)
    {
        _routerConfig = [[EcoRouterConfigModel alloc] init];
    }
    
    return _routerConfig;
}

#pragma mark - 打开Link地址
/*
 scheme://[User]:[Password]@[target]/[action]?[params]#[#Fragment]
 url sample:
 aaa://eco:123@targetA/actionB?id=1234
 */

+ (BOOL)openUrl:(NSString *)url from:(UIViewController *)viewController completion:(EcoRouterCallback)routerCallback
{
    return [[self shared] openUrl:url from:(UIViewController *)viewController completion:routerCallback];
}


- (BOOL)openUrl:(NSString *)url from:(UIViewController *)viewController completion:(EcoRouterCallback)routerCallback
{
    EcoRouterUrlModel *routerUrlModel = [EcoRouterUrlModel parseObjectWithURL:url];
    
    if (!routerUrlModel)
    {
        //调用的Url无法解析
        if ([self.exceptionDelegate respondsToSelector:@selector(routerCannotParseUrl:)])
        {
            [self.exceptionDelegate routerCannotParseUrl:url];
        }
        else
        {
            [self addErrorTip:URL_ERROR];
        }
        return NO;
    }
    else if (![routerUrlModel.scheme isEqualToString:self.routerConfig.urlScheme])
    {
        //调用的Url的scheme不匹配
        if ([self.exceptionDelegate respondsToSelector:@selector(routerCannotMatchScheme:)])
        {
            [self.exceptionDelegate routerCannotMatchScheme:routerUrlModel.scheme];
        }
        else
        {
            [self addErrorTip:SCHEME_ERROR];
        }
        return NO;
    }
    else if ((![routerUrlModel.user isEqualToString:self.routerConfig.user] ||
              ![routerUrlModel.password isEqualToString:self.routerConfig.password])&&
             !self.routerConfig.urlVerifySkip)
    {
        //远程调用账号密码错误(非法调用)
        if ([self.exceptionDelegate respondsToSelector:@selector(routerCannotMatchUserOrPasswordWithUser:andPassword:)])
        {
            [self.exceptionDelegate routerCannotMatchUserOrPasswordWithUser:routerUrlModel.user
                                                                andPassword:routerUrlModel.password];
        }
        else
        {
            [self addErrorTip:VERITY_ERROR];
        }
        return NO;
    }


    BOOL result = [self performTarget:routerUrlModel.target action:routerUrlModel.action parameters:routerUrlModel.paramsDic from:viewController completion:routerCallback];

    return result;
}


+ (BOOL)performTarget:(NSString *)targetName action:(NSString *)actionName parameters:(NSDictionary *)paramsDic from:(UIViewController *)viewController completion:(EcoRouterCallback)routerCallback
{
    return [[self shared] performTarget:targetName action:actionName parameters:paramsDic from:viewController completion:routerCallback];
}


- (BOOL)performTarget:(NSString *)targetName action:(NSString *)actionName parameters:(NSDictionary *)paramsDic from:(UIViewController *)viewController completion:(EcoRouterCallback)routerCallback
{
    
    NSString *targetClassString = [NSString stringWithFormat:@"%@%@", targetName,FILTER_SUFFIX];
    NSString *actionString = [NSString stringWithFormat:@"%@%@", actionName,ACTION_SUFFIX];
    NSString *openClassName = self.urlMapDic[targetName][actionName];
    
    NSMutableDictionary *newParamsDic = nil;

    if (paramsDic)
    {
        newParamsDic = [NSMutableDictionary dictionaryWithDictionary:paramsDic];
    }
    else
    {
        newParamsDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    if (routerCallback)
    {
        newParamsDic[@"callback"] = routerCallback;
    }

    
    if (!openClassName.length)
    {
        //映射不到相关类
        if ([self.exceptionDelegate respondsToSelector:@selector(routerCannotMapClass:)])
        {
            [self.exceptionDelegate routerCannotMapClass:openClassName];
        }
        else
        {
            [self addErrorTip:NOTFOUND_ERROR];
        }
        return NO;
    }
    
    
    id target = self.cachedTarget[targetClassString];
    if (!target)
    {
        Class targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    
    if (!target)
    {
        return NO;
    }
    
    SEL check = NSSelectorFromString(@"checkOpenClass:actionName:params:from:");
    if ([target respondsToSelector:check])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        BOOL result = [[target performSelector:check withObjects:@[openClassName,actionString,newParamsDic,viewController]] boolValue];
#pragma clang diagnostic pop
        if (!result)
        {
            //拒绝跳转
            if ([self.exceptionDelegate respondsToSelector:@selector(routerForbiddenOpenClass:)])
            {
                [self.exceptionDelegate routerForbiddenOpenClass:openClassName];
            }
            else
            {
                [self addErrorTip:FORBIDDEN_ERROR];
            }
        }
        
        return result;
    }
    return NO;
}

#pragma mark - 错误提示
- (void)addErrorTip:(NSString *)errorMsg
{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [viewController presentViewController:alertController animated:YES completion:^{
            
        }];
}

#pragma mark - 释放已保存Target类
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName
{
    NSString *targetClassString = [NSString stringWithFormat:@"%@%@", targetName,FILTER_SUFFIX];
    [self.cachedTarget removeObjectForKey:targetClassString];
}

#pragma mark - getters and setters
- (NSMutableDictionary *)cachedTarget
{
    if (_cachedTarget == nil)
    {
        _cachedTarget = [[NSMutableDictionary alloc] init];
    }
    return _cachedTarget;
}

@end
