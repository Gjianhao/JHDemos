//
//  Employee+CoreDataProperties.m
//  Demo_Pods
//
//  Created by gjh on 2021/1/12.
//  Copyright © 2021 gjh. All rights reserved.
//
//

#import "Employee+CoreDataProperties.h"

@implementation Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
}

@dynamic birthday;
@dynamic height;
@dynamic name;

@end
