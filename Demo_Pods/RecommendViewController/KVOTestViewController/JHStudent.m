//
//  JHStudent.m
//  Demo_Pods
//
//  Created by gjh on 2021/1/20.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHStudent.h"
#import "JHPerson.h"

@implementation JHStudent

- (NSString *)info {
    return [NSString stringWithFormat:@"student_name = %@, student_age = %ld", _jhPerson.name, (long)_jhPerson.age];
}

- (void)setInfo:(NSString *)info {
    NSArray *arr = [info componentsSeparatedByString:@"#"];
    self.jhPerson.name = [arr objectAtIndex:0];
    self.jhPerson.age = [[arr objectAtIndex:1] integerValue];
}
// 此时需要观察Student 类实例中 info 属性值的变化, 而 info 属性的值依赖于 jhPerson 属性的值, 那么如何确定这种依赖关系呢?
// 开发者要手动实现 info 的get 和 set 方法,还要实现 keyPathsForValuesAffectingInfo
// 这个方法是用来告诉系统info 属性依赖于其他哪些属性.
// 而且两个方法都返回包含依赖 key-path的集合
// 在下面例子中,	info 属性依赖于 Person 的 age 和 name 属性,  当 age 和 name 属性发生改变时,info 的观察者都会得到通知,
+ (NSSet<NSString *> *)keyPathsForValuesAffectingInfo
{
    return [NSSet setWithObjects:@"jhPerson.age", @"jhPerson.name", nil];
}
//+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
//
//}
//- (id)valueForUndefinedKey:(NSString *)key {
//    return @"";
//}
@end
