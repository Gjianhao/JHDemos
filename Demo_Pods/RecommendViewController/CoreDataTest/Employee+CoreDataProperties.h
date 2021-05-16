//
//  Employee+CoreDataProperties.h
//  Demo_Pods
//
//  Created by gjh on 2021/1/12.
//  Copyright © 2021 gjh. All rights reserved.
//
//

#import "Employee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *birthday;
@property (nonatomic) float height;
@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
