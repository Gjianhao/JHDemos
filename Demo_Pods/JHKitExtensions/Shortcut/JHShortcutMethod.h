//
//  JHShortcutMethod.h
//  Demo_Pods
//
//  Created by gjh on 2021/3/27.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <UIKit/UIKit.h>


/// 为ViewController添加navController
/// @param viewController viewController
UINavigationController *addNavigationController(UIViewController *viewController);

/// 初始化tabBarItem
/// @param tabBarItem tabBarItem
/// @param title 标题
/// @param image 图片
/// @param imageHL 高亮图片
void initTabBarItem(UITabBarItem *tabBarItem, NSString *title, NSString *image, NSString *imageHL);
