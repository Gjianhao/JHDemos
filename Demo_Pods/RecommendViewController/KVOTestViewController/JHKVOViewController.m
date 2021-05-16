//
//  JHKVOViewController.m
//  Demo_Pods
//
//  Created by gjh on 2021/1/20.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHKVOViewController.h"
#import "JHStudent.h"
#import "JHPerson.h"

@interface JHKVOViewController ()

@property (nonatomic, strong) JHStudent *jhStudent;

@end

@implementation JHKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _jhStudent = [[JHStudent alloc] init];
    _jhStudent.jhPerson = [[JHPerson alloc] init];
    // 虽然学生类监听的是 info 属性的变化,但是 info 是依赖 name 和 age 这两个属性,所以这两个属性变化了,info 也是有反应的
    [_jhStudent addObserver:self forKeyPath:@"info" options:NSKeyValueObservingOptionNew context: @"info"];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _jhStudent.jhPerson.age = 10;
    _jhStudent.jhPerson.name = @"123";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"info"]) {
        NSLog(@"new info :%@", change[NSKeyValueChangeNewKey]);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    [_jhStudent removeObserver:self forKeyPath:@"info"];
}

@end
