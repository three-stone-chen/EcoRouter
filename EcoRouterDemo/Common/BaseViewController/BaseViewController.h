//
//  BaseViewController.h
//  RouterTest
//
//  Created by 陈磊 on 2017/3/1.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Router.h"
#import "EcoRouter.h"

@interface BaseViewController : UIViewController

///添加左Item
- (void)addLeftItem;

///添加右Item
- (void)addRightItem;

@end
