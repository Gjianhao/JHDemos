//
//  DetailNewsViewController.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/14.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "DetailNewsViewController.h"
#import <WebKit/WebKit.h>
#import "JHMediator.h"

@interface DetailNewsViewController ()<WKNavigationDelegate>

@property (nonatomic, strong, readwrite) WKWebView *webView;
@property (nonatomic, strong, readwrite) UIProgressView *progressView;
@property (nonatomic, copy, readwrite) NSString *url;

@end

@implementation DetailNewsViewController

+ (void)load {
    [JHMediator registerScheme:@"detail://" processBlock:^(NSDictionary * _Nonnull params) {
        NSString *url = (NSString *)[params objectForKey:@"url"];
        UINavigationController *navigationVC = (UINavigationController *)[params objectForKey:@"controller"];
        DetailNewsViewController *detailVC = [[DetailNewsViewController alloc] initWithUrl:url];
        [navigationVC pushViewController:detailVC animated:YES];
    }];
}

- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"second");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT +44, SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBARHEIGHT - 44)];
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.view addSubview:self.webView];

    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT +44, SCREEN_WIDTH, 20)];
    [self.view addSubview:self.progressView];

    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.progressView.progress = self.webView.estimatedProgress;
    if (self.progressView.progress == 1.0) {
        self.progressView.hidden = YES;
    }
}

@end
