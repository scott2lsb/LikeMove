//
//  LMUserBL.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "LMUserActBL.h"
#import "UserActDA.h"
@implementation LMUserActBL
-(id) init
{
    self = [super init];
    
    if (self) {
        _da = [UserActDA new];
    }
    return self;
}
-(User *)login:(NSString *)phone withPassword:(NSString *)pwd{
    _da.delegate=self;
    [_da login:phone withPassword:pwd];
    return nil;
}
-(BOOL)regist:(NSString *)phone withPassword:(NSString *)pwd{
    _da.delegate=self;
    [_da regist:phone withPassword:pwd];
    return 1;
}

-(void)editUserInfo:(NSString *)nickName sex:(NSString *)sex age:(NSString *)age{
    _da.delegate=self;
    [_da editUserInfo:nickName sex:sex age:age];
}
#pragma mark - LMUserActDADelegate
-(void)loginSuccess{
    [_delegate loginSuccess];
}
-(void)loginFail{
    [_delegate loginFail];
}
-(void)registSuccess{
    [_delegate registSuccess];
}
-(void)registFail{
    [_delegate registFail];
}
-(void)editUserInfoSuccess{
    [_delegate editUserInfoSuccess];
}
-(void)editUserInfoFail{
    [_delegate editUserInfoFail];
}
@end
