//
//  RecommendViewController.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/28.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "RecommendViewController.h"
#import "JHKVOViewController.h"
#import "JHQuartz2DTestViewController.h"
#import "JHCALayerTestViewController.h"
#import "JHGCDTestViewController.h"
#import "JHCoreAnimationViewController.h"
// MVP 设计模式
//#import "JHUserPresenter.h"

@interface RecommendViewController ()<UITableViewDelegate, UITableViewDataSource>


// 主列表视图
@property (nonatomic, strong, readwrite) UITableView *mainTableView;
/// 显示的列表资源
@property (nonatomic, strong) NSArray *dataSourceArr;

@end

@implementation RecommendViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle_selected@2x.png"];
    }
    return self;
}

- (NSArray *)dataSourceArr {
    if (!_dataSourceArr) {
        _dataSourceArr = [NSArray arrayWithObjects:@"GCD Test", @"Runtime Test", @"Runloop Test", @"KVO Test", @"Quartz2D Test", @"CALayer Test", @"CoreAnimation Test", nil];
    }
    return _dataSourceArr;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"A--viewDidLoad");
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_AND_NAVIGATION_HEIGHT)];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"A--viewWillAppear");
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"A--viewDidAppear");
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"A--viewWillDisappear");
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"A--viewDidDisappear");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.textLabel.text = self.dataSourceArr[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        JHGCDTestViewController *gcdVC = [[JHGCDTestViewController alloc] init];
        [self.navigationController pushViewController:gcdVC animated:YES];
    } else if (indexPath.row == 1) {
        JHKVOViewController *kvoVC = [[JHKVOViewController alloc] init];
        [self.navigationController pushViewController:kvoVC animated:YES];
    } else if (indexPath.row == 2) {
        JHKVOViewController *kvoVC = [[JHKVOViewController alloc] init];
        [self.navigationController pushViewController:kvoVC animated:YES];
    } else if (indexPath.row == 3) {
        JHKVOViewController *kvoVC = [[JHKVOViewController alloc] init];
        [self.navigationController pushViewController:kvoVC animated:YES];
    } else if (indexPath.row == 4) {
        JHQuartz2DTestViewController *quartVC = [[JHQuartz2DTestViewController alloc] init];
        [self.navigationController pushViewController:quartVC animated:YES];
    } else if (indexPath.row == 5) {
        JHCALayerTestViewController *calayerVC = [[JHCALayerTestViewController alloc] init];
        [self.navigationController pushViewController:calayerVC animated:YES];
    } else if (indexPath.row == 6) {
        JHCoreAnimationViewController *animationVC = [[JHCoreAnimationViewController alloc] init];
        [self.navigationController pushViewController:animationVC animated:YES];
    }
}

#pragma mark - 监听屏幕旋转
/// 监听屏幕旋转
/// @param size size
/// @param coordinator 协调器
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
}
@end
