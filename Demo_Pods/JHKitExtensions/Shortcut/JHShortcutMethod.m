//
//  JHShortcutMethod.m
//  Demo_Pods
//
//  Created by gjh on 2021/3/27.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHShortcutMethod.h"

UINavigationController *addNavigationController(UIViewController *viewController) {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    return nav;
}

void initTabBarItem(UITabBarItem *tabBarItem, NSString *title, NSString *image, NSString *imageHL) {
    [tabBarItem setTitle:title];
    [tabBarItem setImage:[UIImage imageNamed:image]];
    [tabBarItem setSelectedImage:[UIImage imageNamed:imageHL]];
}

