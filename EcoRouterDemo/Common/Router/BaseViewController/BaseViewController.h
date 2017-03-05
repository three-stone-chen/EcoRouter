//
//  BaseViewController.h
//  RouterTest
//
//  Created by 陈磊 on 2017/3/1.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouterTool.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSDictionary *paramDic;

///添加左Item
- (void)addLeftItem;

///添加右Item
- (void)addRightItem;

@end
