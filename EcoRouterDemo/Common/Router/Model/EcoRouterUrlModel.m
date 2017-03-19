//
//  EcoUrlModel.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/18.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "EcoRouterUrlModel.h"

@interface EcoRouterUrlModel ()


@end


@implementation EcoRouterUrlModel

#pragma mark - 初始化
+ (instancetype)parseObjectWithURL:(NSString *)urlString
{
    return [[EcoRouterUrlModel alloc] initWithURL:urlString];
}

- (instancetype)initWithURL:(NSString *)urlString
{
    self = [super init];
    
    urlString = (urlString && ![urlString isKindOfClass:[NSNull class]]) ? urlString : @"";
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (self)
    {
        self.scheme = url.scheme;
        self.user = url.user;
        self.password = url.password;
        self.target = url.host;
        self.action = [url.path componentsSeparatedByString:@"/"].lastObject;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *param in [url.query componentsSeparatedByString:@"&"])
        {
            NSArray *elementArray = [param componentsSeparatedByString:@"="];
            if([elementArray count] < 2)
                continue;
            [dic setObject:[elementArray lastObject] forKey:[elementArray firstObject]];
        }
        self.paramsDic = dic;
    }
    return self;
}

@end
