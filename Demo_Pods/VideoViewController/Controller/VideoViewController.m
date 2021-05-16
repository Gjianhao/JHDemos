//
//  VideoViewController.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/24.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoCoverViewCell.h"
#import "VideoToolBar.h"

@interface VideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation VideoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/video_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/16*9 + VideoToolBarHeight);
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[VideoCoverViewCell class] forCellWithReuseIdentifier:@"VideoCoverViewCell"];
    
    [self.view addSubview:collectionView];

}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCoverViewCell" forIndexPath:indexPath];
    
    if ([collectionCell isKindOfClass:[VideoCoverViewCell class]]) {
        [((VideoCoverViewCell *)collectionCell) layoutWithVideoCoverUrl:@"icon.bundle/splash.png" VideoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    }
    return collectionCell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.item % 3 == 0) {
//        return CGSizeMake(SCREEN_WIDTH, 100);
//    } else {
//        return CGSizeMake((SCREEN_WIDTH-10)/2, 300);
//    }
//}

@end
