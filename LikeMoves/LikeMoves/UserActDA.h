//
//  UserDA.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-15.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "LMUserActDADelegate.h"
@interface UserActDA : NSObject

@property (weak, nonatomic) id <LMUserActDADelegate> delegate;
//+(UserActDA*) sharedManager;  在数据库访问中使用单例模式

/**
 *  请求服务器，登陆操作，成功返回用户信息，不成功提示登陆不成功
 *
 *  @param phone 用户登陆手机号
 *  @param pwd   用户密码
 *
 *  @return 用户详情
 */
-(User*) login:(NSString*)phone withPassword:(NSString*)pwd;
/**
 *  注册接口，向服务器发送注册操作
 *
 *  @param phone 登陆用手机号
 *  @param pwd   用户密码
 *
 *  @return 是否注册成功
 */
-(BOOL) regist:(NSString*)phone withPassword:(NSString*)pwd;

-(void) resetPwd:(NSString*)phone withNewPwd:(NSString*)pwd;

-(BOOL) editUserInfo:(NSString*)nickName sex:(int)sex age:(int)age ;


@end