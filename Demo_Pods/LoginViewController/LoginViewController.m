//
//  LoginViewController.m
//  Demo_Pods
//
//  Created by gjh on 2020/12/7.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "UIImage+Extension.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIView *newsView;

@property (nonatomic, strong) LoginViewModel *loginViewModel;
@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"登录";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/home_selected@2x.png"];
    }
    return self;
}

- (LoginViewModel *)loginViewModel {
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 绘制界面布局
    [self setupUI];
    [self reLoadUI];
    [self bindViewModel];
    // 创建登录命令
    
    [self loginEvent];
    
    
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}
- (void)bindViewModel {
    
    // 给视图模型的账号和密码绑定信号，只要文本框的内容一改变，就给这个赋值
    // 必须使用self.  否则不能监听到
    RAC(self.loginViewModel, account) = _accountTextField.rac_textSignal;
    RAC(self.loginViewModel,pwd) = _pwdTextField.rac_textSignal;
    
    // 设置按钮能否点击
    RAC(self.loginBtn, enabled) = self.loginViewModel.loginEnableSignal;
}

- (void)loginEvent {
    // 监听按钮的点击
    @weakify(self)
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        NSLog(@"点击登录按钮");
        [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];

        // 执行命令
        [self.loginViewModel.loginCommand execute:nil];
    }];
}

- (void)setupUI {

    // view
    [self.view addSubview:({
        self.newsView = [[UIView alloc] init];
        self.newsView.layer.cornerRadius = 10;
        self.newsView;
    })];
    [self.newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT + 10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    // 添加头像
    [self.view addSubview:({
        self.logoImageView = [[UIImageView alloc] init];
        self.logoImageView.layer.cornerRadius = 10;
        self.logoImageView;
    })];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT + 50);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    [self.view addSubview:({
        self.accountTextField = [[UITextField alloc] init];
        self.accountTextField.placeholder = @"账号";
        self.accountTextField.backgroundColor = [UIColor lightGrayColor];
        self.accountTextField;
    })];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(100);
        make.right.mas_equalTo(-100);
        make.height.mas_equalTo(30);
    }];
    [self.view addSubview:({
        self.pwdTextField = [[UITextField alloc] init];
        self.pwdTextField.placeholder = @"密码";
        self.pwdTextField.backgroundColor = [UIColor lightGrayColor];
        self.pwdTextField;
    })];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(300);
        make.left.mas_equalTo(100);
        make.right.mas_equalTo(-100);
        make.height.mas_equalTo(30);
    }];
    [self.view addSubview:({
        self.loginBtn = [[UIButton alloc] init];
        self.loginBtn.backgroundColor = [UIColor redColor];
        [self.loginBtn.titleLabel setTextColor:[UIColor blueColor]];
        self.loginBtn;
    })];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(400);
        make.left.mas_equalTo(100);
        make.right.mas_equalTo(-100);
        make.height.mas_equalTo(30);
    }];
        
}

- (void)reLoadUI {
//    self.logoImageView.image = [[UIImage imageNamed:@"videoCover"] imageWithCornerRadius:10 ofSize:CGSizeMake(80, 80)];
    self.logoImageView.image = [UIImage imageNamed:@"videoCover"];
//    [self.logoImageView.image = [UIImage imageNamed:@"videoCover"] sd_roundedCornerImageWithRadius:10 corners:UIRectCornerAllCorners borderWidth:5 borderColor:[UIColor redColor]];
    self.newsView.backgroundColor = [UIColor yellowColor];
}
@end
