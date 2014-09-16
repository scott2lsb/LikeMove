//
//  LMUserBLDelegate.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-15.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LMUserBLDelegate <NSObject>

@optional
/**
 *  登陆成功回调
 */
-(void)loginSuccess;
/**
 *  登陆失败后调用此接口
 */
-(void)loginFail;

-(void)registSuccess;
-(void)registFail;

-(void)resetPwdSuccess;
-(void)resetPwdFail;

-(void)editUserInfoSuccess;
-(void)editUserInfoFail;

@end
