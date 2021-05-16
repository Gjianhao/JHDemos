//
//  JHAccountViewController.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/8.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHAccountViewController.h"
#import "JHUserManager.h"
#import "JHRegisterViewController.h"
#import "JHLoginViewController.h"

#define     HEIGHT_BUTTON       50
#define     EDGE_BUTTON         35

typedef NS_ENUM(NSUInteger, JHAccountButtonType) {
    JHAccountButtonTypeRegister,
    JHAccountButtonTypeLogin,
    JHAccountButtonTypeTest
};

@implementation JHAccountViewController

- (void)loadView {
    [super loadView];
    
    // 视图大小
    CGSize viewSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    NSString *viewOrientation = @"Portrait";          // 横屏请设置成@"Landscape"
    NSArray *launchImages = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    // 要获取的启动图片的名字,需要注意的是，如果你不是用LaunchImage来做启动图片的话，在 [NSBundle mainBundle] infoDictionary] 中是无法找到@"UILaunchImages" 这个key的。
    NSString *launchImageName = nil;
    for (NSDictionary *dict in launchImages) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    // 加载一个启动图
    self.view.addImageView(1).image(TLImage(launchImageName)).masonry(^(__kindof UIView *sender, MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    });
    
    // 定义一个创建button的代码块
    UIButton *(^createButton)(NSString *title,UIColor *bgColor, NSInteger tag) = ^UIButton *(NSString *title,UIColor *bgColor, NSInteger tag) {
        UIButton *button = UIButton.zz_create(tag).backgroundColor(bgColor).title(title).titleFont([UIFont systemFontOfSize:19])
        .cornerRadius(5.0f).view;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        return button;
    };
    
    // 注册按钮
    UIButton *registerButton = createButton(@"注 册", [UIColor redColor], JHAccountButtonTypeRegister);
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(EDGE_BUTTON);
        make.bottom.mas_equalTo(-EDGE_BUTTON * 2);
        make.width.mas_equalTo((SCREEN_WIDTH - EDGE_BUTTON * 3) / 2);
        make.height.mas_equalTo(HEIGHT_BUTTON);
    }];
    
    // 登录按钮
    UIButton *loginButton = createButton(@"登 录", [UIColor colorGreenDefault], JHAccountButtonTypeLogin);
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-EDGE_BUTTON);
        make.size.and.bottom.mas_equalTo(registerButton);
    }];
    
    // 测试按钮
    UIButton *testButton = createButton(@"使用测试账号登录", [UIColor clearColor], JHAccountButtonTypeTest);
    [testButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.view addSubview:testButton];
    [testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(EDGE_BUTTON);
        make.right.mas_equalTo(-EDGE_BUTTON);
        make.height.mas_equalTo(HEIGHT_BUTTON);
    }];
}

#pragma mark - 按钮的事件响应
- (void)buttonClicked:(UIButton *)sender {
    if (sender.tag == JHAccountButtonTypeRegister) {
        JHRegisterViewController *registerVC = [[JHRegisterViewController alloc] init];
        TLWeakSelf(registerVC);
        TLWeakSelf(self);
        [registerVC setRegisterSuccess:^{
            [weakregisterVC dismissViewControllerAnimated:NO completion:^{
                if (weakself.loginSuccess) {
                    weakself.loginSuccess();
                }
            }];
        }];
        [self presentViewController:registerVC animated:YES completion:nil];
    } else if (sender.tag == JHAccountButtonTypeLogin) {
        JHLoginViewController *loginVC = [[JHLoginViewController alloc] init];
        TLWeakSelf(loginVC);
        TLWeakSelf(self);
        [loginVC setLoginSuccess:^{
            [weakloginVC dismissViewControllerAnimated:NO completion:^{
                if (weakself.loginSuccess) {
                    weakself.loginSuccess();
                }
            }];
        }];
        [self presentViewController:loginVC animated:YES completion:nil];
    } else if (sender.tag == JHAccountButtonTypeTest) {
        [[JHUserManager sharedInstance] loginTestAccount];
        if (self.loginSuccess) {
            self.loginSuccess();
        }
    }
}

@end
