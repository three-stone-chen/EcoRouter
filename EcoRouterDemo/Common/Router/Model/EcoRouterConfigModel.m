//
//  EcoRouterConfigModel.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/18.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "EcoRouterConfigModel.h"

@implementation EcoRouterConfigModel

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.urlVerifySkip = YES;
    }
    return self;
}

@end
