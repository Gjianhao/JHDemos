//
//  JHUser.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/1.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHUser.h"
#import "JHUserDetail.h"
#import "JHUserSetting.h"
#import "JHUserChatSetting.h"

@implementation JHUser

- (id)init
{
    if (self = [super init]) {
        [JHUser mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"detailInfo" : @"JHUserDetail",
                      @"userSetting" : @"JHUserSetting",
                      @"chatSetting" : @"JHUserChatSetting",};
        }];
    }
    return self;
}

- (void)setUsername:(NSString *)username
{
    if ([username isEqualToString:_username]) {
        return;
    }
    _username = username;
    if (self.remarkName.length == 0 && self.nikeName.length == 0 && self.username.length > 0) {
        self.pinyin = username.pinyin;
        self.pinyinInitial = username.pinyinInitial;
    }
}

- (void)setNikeName:(NSString *)nikeName
{
    if ([nikeName isEqualToString:_nikeName]) {
        return;
    }
    _nikeName = nikeName;
    if (self.remarkName.length == 0 && self.nikeName.length > 0) {
        self.pinyin = nikeName.pinyin;
        self.pinyinInitial = nikeName.pinyinInitial;
    }
}

- (void)setRemarkName:(NSString *)remarkName
{
    if ([remarkName isEqualToString:_remarkName]) {
        return;
    }
    _remarkName = remarkName;
    if (_remarkName.length > 0) {
        self.pinyin = remarkName.pinyin;
        self.pinyinInitial = remarkName.pinyinInitial;
    }
}

#pragma mark - Getter
- (NSString *)showName
{
    return self.remarkName.length > 0 ? self.remarkName : (self.nikeName.length > 0 ? self.nikeName : self.username);
}

- (JHUserDetail *)detailInfo
{
    if (_detailInfo == nil) {
        _detailInfo = [[JHUserDetail alloc] init];
    }
    return _detailInfo;
}

@end
