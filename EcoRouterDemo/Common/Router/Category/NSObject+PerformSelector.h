//
//  NSObject+PerformSelector.h
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/19.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformSelector)

- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;

@end
