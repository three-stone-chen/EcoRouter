//
//  ViewController.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "MainViewController.h"
#import "EcoRouter.h"
#import <WebKit/WebKit.h>
#import "BaseViewController.h"

@interface MainViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation MainViewController

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化UI
    [self initUI];
    //加载html
    [self loadWebView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化UI
- (void)initUI
{
    [self.view addSubview:self.wkWebView];
}


- (WKWebView *)wkWebView
{
    if (!_wkWebView)
    {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _wkWebView.navigationDelegate = self;
    }
    return _wkWebView;
}

#pragma mark - 加载webView
- (void)loadWebView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"router" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"htmlString===%@",htmlString);
    [_wkWebView loadHTMLString:htmlString baseURL:nil];
}

#pragma mark - delegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
    NSURL *url = navigationAction.request.URL;
    if (WKNavigationTypeLinkActivated == navigationAction.navigationType&& [url.scheme isEqualToString:@"eco"])
    {
        [self doUrl:url.absoluteString];
        policy = WKNavigationActionPolicyCancel;
    }
    decisionHandler(policy);
}

#pragma mark - 跳转界面
- (void)doUrl:(NSString *)urlString
{
    NSLog(@"urlString +==== %@",urlString);
    UIViewController *viewController = [EcoRouter objectForURL:urlString];
    if (viewController && [viewController isKindOfClass:[UIViewController class]])
    {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"未匹配到页面" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}

@end
