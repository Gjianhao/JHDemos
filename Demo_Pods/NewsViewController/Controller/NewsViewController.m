//
//  NewsViewController.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/24.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "DetailNewsViewController.h"
#import "DeleteView.h"
#import "NewsListViewModel.h"
#import "NewsItemModel.h"
#import "JHMediator.h"

#import "NSObject+Calculator.h"

#import "Person.h"
#import "NSObject+KVO.h"

#import "CalculateManager.h"

#import "NSObject+RACKVOWrapper.h"

@interface NewsViewController ()<UITableViewDelegate, UITableViewDataSource, NewsTableViewCellDeleteBtnDelegate>

/// 显示的列表资源
@property (nonatomic, strong) NSArray<NewsItemModel *> *dataSourceArr;

@property (nonatomic, strong, readwrite) UITableView *mainTableView;

@property (nonatomic, strong) NewsListViewModel *newsListViewModel;

@property (nonatomic, strong) Person *person;

@property (nonatomic, strong) id<RACSubscriber> subscriber;

@end

@implementation NewsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
    }
    return self;
}

- (NewsListViewModel *)newsListViewModel {
    if (!_newsListViewModel) {
        _newsListViewModel = [[NewsListViewModel alloc] init];
    }
    return _newsListViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"头条";
    self.navigationController.navigationItem.backButtonTitle = @"返回";
    // 初始化资源数组
    self.dataSourceArr = [NSArray array];

    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_AND_NAVIGATION_HEIGHT)];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    _mainTableView.rowHeight = 100;
    [self.view addSubview:_mainTableView];
    
    _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsListViewModel.command execute:nil];
    }];
    
    // viewModel的绑定
    [self bindNewListViewModel];
    
    // 20201206  注释 ：换做使用RACCommand的方式取数据
//    LRWeakSelf(self)
//    @weakify(self)
//    [_newsListViewModel loadListDataWithFinishBlock:^(BOOL finish, NSArray<NewsItemModel *> * _Nonnull dataArr) {
//        if (finish) {
//            @strongify(self)
//            self.dataSourceArr = dataArr;
//            [self.mainTableView reloadData];
//        }
//    }];    
    
}
#pragma mark - life cycle
- (void)dealloc {
    [_person removeObserver:self forKeyPath:@"name"];
}
#pragma mark - RAC的应用实例

- (void)RAC_liftSelector {
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求热销数据");
        [subscriber sendNext:@"hot Data"];
        return nil;
    }];
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求最新数据");
        [subscriber sendNext:@"New Data"];
        return nil;
    }];
    // 数组：存放信号
    // 当数组中的所有信号都发送数据的时候。才会执行方法
    // 方法的参数：必须跟数组的信号一一对应
    // 方法的参数，就是每一个信号发送的数据
    [self rac_liftSelector:@selector(updateUIWithHotData:newData:) withSignalsFromArray:@[hotSignal, newSignal]];
}

- (void)updateUIWithHotData:(NSString *)hotData newData:(NSString *)newData {
    NSLog(@"%@----%@", hotData, newData);
}

- (void)RAC_insteadOfKVOAndNotificationCenter {
    // 代替通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"change" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
    }];
    
    // 这个用起来不是很方便 还要导入头文件
    [_mainTableView rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        
    }];
    
    [[_mainTableView rac_valuesForKeyPath:@"frame" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}
// 代替代理
- (void)RAC_insteadOfDelegate {
    
    // 监听某个对象有没有调用某个方法
    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"调用了viewWillAppear");
    }];
}

- (void)RAC_Sequence {
    // 遍历下数组
    [self.dataSourceArr.rac_sequence.signal subscribeNext:^(NewsItemModel * _Nullable x) {
        NSLog(@"%@", x);
    }];
    // 遍历字典
    NSDictionary *dict = @{@"name":@"gjh", @"age":@22, @"work":@"iOS"};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        // 这是一个强大的宏
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"%@--%@", key, value);
    }];
}

- (void)RACSubject {
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"gjh"];
}

- (void)codeThinking {
    
    // 响应式编程思想
    Person *p = [[Person alloc] init];
//    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [p jh_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    _person = p;
    // 函数响应式FRP
    CalculateManager *manager = [[CalculateManager alloc] init];
    int res = [[manager calculate:^int(int result) {
        result += 5;
        result *= 6;
        return result;
    }] result];
    NSLog(@"%d",res);
}

- (void)RACSignal {
    // RACSignal 有数据产生的时候，就使用RACSignal
    // 使用步骤：1、创建信号 2、订阅信号 3、发送信号
    // 创建信号 (冷信号)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        self.subscriber = subscriber;
        // 3、发送数据
        [subscriber sendNext:@1];
        return [RACDisposable disposableWithBlock:^{
            // 只要信号取消订阅，就会来到这里
            // 只要一个信号发送完毕，我们就会取消订阅，只要订阅者在，就不会自动取消信号订阅
            NSLog(@"信号被取消订阅了");
        }];
    }];
    
    // 订阅信号（热信号）
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        // x就是信号发送的内容
        NSLog(@"%@",x);
    }];
    // 取消订阅信号
    [disposable dispose];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"new Value:%@", _person.name);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 绑定viewModel 加载网络数据

- (void)bindNewListViewModel {
    
    // 将命令执行后的数据交给controller
    @weakify(self)
    [self.newsListViewModel.command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.dataSourceArr = x;
        [self.mainTableView reloadData];
    }];
    // 执行command
    [self.newsListViewModel.command execute:nil];
    
    // 监听命令是否执行完毕,skip表示跳过第一次信号
    [[self.newsListViewModel.command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        if (x.boolValue) {
            NSLog(@"正在加载");
            [SVProgressHUD show];
        } else {
            NSLog(@"加载完成");
            [self.mainTableView.mj_header endRefreshing];
            [SVProgressHUD dismiss];
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";

    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }

    cell.deteleBtnDelegate = self;
    [cell layoutTableViewCell:[_dataSourceArr objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsItemModel *model = [_dataSourceArr objectAtIndex:indexPath.row];
//    __kindof UIViewController *detailNewsVC = [JHMediator detailControllerWithUrl:model.url];
//    [self.navigationController pushViewController:detailNewsVC animated:YES];
    
    [JHMediator openUrl:@"detail://" params:@{@"url":model.url, @"controller":self.navigationController}];
    
    /* 记录已读状态 */
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:model.uniquekey];
}

#pragma mark - NewsTableViewCellDeleteBtnDelegate

- (void)tableView:(UITableViewCell *)tableViewCell clickDeleteBtn:(UIButton *)deleteBtn {
    DeleteView *deleteView = [[DeleteView alloc] initWithFrame:self.view.bounds];
    CGRect rect = [tableViewCell convertRect:deleteBtn.frame toView:nil];
    [deleteView showDeleteBtnViewFromPoint:rect.origin clickBolck:^{
        // 删除cell的逻辑
        [self.mainTableView deleteRowsAtIndexPaths:@[[self.mainTableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
        NSLog(@"123");
    }];
}

#pragma mark - 链式编程思想
- (void)lianshiCode {
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(10);
        make.right.mas_equalTo(10);
    }];
    int w = [NSObject JH_CalculatorMaker:^(CalculatorManager * _Nonnull manager) {
        manager.add(5).add(7);
    }];
    int q = [NSObject JH_CalculatorMaker:^(CalculatorManager * _Nonnull manager) {
        manager.add(10).add(9);
    }];
    NSLog(@"%d", w + q);
}
@end
