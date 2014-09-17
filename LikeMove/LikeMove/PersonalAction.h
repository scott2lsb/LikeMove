//
//  PersonalAction.h
//  LikeMove
//
//  Created by 粒橙Leo on 14-9-12.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
/**
 *  定义服务器接口字段
 */
#define BaseURLString @"http://www.haoapp123.com/app/localuser/aidongdong/api.php?"

@interface PersonalAction : NSObject
+(PersonalAction*) sharePersonalAction;
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

-(BOOL) editUserinfo:(NSString*)nickName sex:(int)sex age:(int)age ;

@end

