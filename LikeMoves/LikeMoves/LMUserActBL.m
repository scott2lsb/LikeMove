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
-(BOOL)regist:(NSString *)phone withPassword:(NSString *)pwd withTrainPlace:(NSString *)trainPlace{
    _da.delegate=self;
    [_da regist:phone withPassword:pwd withTrainPlace:trainPlace];
    return 1;
}

-(void)editUserInfo:(NSString *)nickName sex:(NSString *)sex age:(NSString *)age trainAddr:(NSString *)trainAdr{
    _da.delegate=self;
  
    [_da editUserInfo:nickName sex:sex age:age trainAddr:trainAdr];
}

-(void)resetPwd:(NSString *)phone withNewPwd:(NSString *)pwd{
    _da.delegate=self;
    [_da resetPwd:phone withNewPwd:pwd];
}
-(void)refreshMyself{
    [_da refreshMyself];
}
-(void)addCoins:(NSInteger)coins{
    [_da addCoins:coins];
};
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
-(void)resetPwdSuccess{
    [_delegate resetPwdSuccess];
}
-(void)resetPwdFail{
    [_delegate resetPwdFail];
}
@end
