//
//  LMUserBL.h
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-14.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "LMUserBLDelegate.h"
#import "LMUserActDADelegate.h"
#import "UserActDA.h"
@interface LMUserActBL : NSObject<LMUserActDADelegate>

@property (weak, nonatomic) id <LMUserBLDelegate> delegate;

@property (strong, nonatomic) UserActDA *da;

-(User *)login:(NSString *)phone withPassword:(NSString *)pwd;

-(BOOL)regist:(NSString *)phone withPassword:(NSString *)pwd withTrainPlace:(NSString *)trainPlace;

-(void)editUserInfo:(NSString*)nickName sex:(NSString*)sex age:(NSString*)age;

-(void)resetPwd:(NSString*)phone withNewPwd:(NSString *)pwd;
@end
