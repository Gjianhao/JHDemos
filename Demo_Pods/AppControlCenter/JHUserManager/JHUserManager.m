//
//  JHUserManager.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/1.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHUserManager.h"
#import "JHUser.h"
#import "JHUserDetail.h"
#import "JHDBUserStore.h"

@implementation JHUserManager
@synthesize user = _user;

+ (JHUserManager *)sharedInstance {
    static JHUserManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JHUserManager alloc] init];
    });
    return manager;
}

- (void)loginTestAccount {
    JHUser *user = [[JHUser alloc] init];
    user.userID = @"1000";
    user.avatarURL = @"https://img01.sogoucdn.com/net/a/04/link?appid=100520145&url=http%3A%2F%2Fcdnimg103.lizhi.fm%2Fradio_cover%2F2017%2F07%2F24%2F2614849727230184452_320x320.jpg";
    user.nikeName = @"郭健豪";
    user.username = @"guo-orion";
    user.detailInfo.qqNumber = @"18710126754";
    user.detailInfo.email = @"kevinbina@163.com";
    user.detailInfo.location = @"陕西 西安";
    user.detailInfo.sex = @"男";
    user.detailInfo.motto = @"Hello world!";
    user.detailInfo.momentsWallURL = @"http://pic1.win4000.com/wallpaper/c/5791e49b37a5c.jpg";
}

- (void)setUser:(JHUser *)user {
    _user = user;
    JHDBUserStore *userStore = [[JHDBUserStore alloc] init];
    if (![userStore updateUser:user]) {
        DDLogError(@"登录数据库失败");
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"loginUid"];
}

- (JHUser *)user {
    if (!_user) {
        if (self.userID.length > 0) {
            JHDBUserStore *userStore = [[JHDBUserStore alloc] init];
            _user = [userStore userByID:self.userID];
            _user.detailInfo.momentsWallURL = @"http://pic1.win4000.com/wallpaper/c/5791e49b37a5c.jpg";
            if (!_user) {
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"loginUid"];
            }
        }
    }
    return _user;
}

- (NSString *)userID {
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginUid"];
    return uid;
}

- (BOOL)isLogin {
    return self.user.userID.length > 0;
}

@end
