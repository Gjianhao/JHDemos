//
//  JHQuartz2DTestViewController.m
//  Demo_Pods
//
//  Created by gjh on 2021/1/21.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHQuartz2DTestViewController.h"
#import "JHLineView.h"

@interface JHQuartz2DTestViewController ()

@end

@implementation JHQuartz2DTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JHLineView *lineView = [[JHLineView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300) / 2, (SCREEN_HEIGHT - 300) / 2, 300, 300)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView];
}


@end
